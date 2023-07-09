# frozen_string_literal: true

class TransactionBatch
  attr_reader :transaction_collection, :account_collection

  def initialize(batch_string)
    @account_collection = AccountCollection.new
    @transaction_collection = TransactionCollection.new

    instructions = get_instructions(batch_string)

    process_instructions(instructions)

    accounts_balances
  end

  def accounts_balances
    @account_collection.accounts.map do |account|
      { account_owner: account.account_owner, balance: account_balance_string(account) }
    end.sort_by { |account| account[:account_owner] }
  end

  private

  def account_balance_string(account)
    return 'error' if account.blocked?

    "$#{@transaction_collection.balance(account.account_owner)}"
  end

  def parse_line(line)
    item = line.split(' ')
    if item.count == 4
      { command: item[0].downcase, name: item[1], card: item[2], amount: item[3].gsub(/[^\d]/, '').to_i }
    elsif item.count == 3
      { command: item[0].downcase, name: item[1], amount: item[2].gsub(/[^\d]/, '').to_i }
    else
      { error: 'Invalid command' }
    end
  end

  def get_instructions(batch_string)
    batch_string.lines.map(&:chomp).map do |line|
      parse_line(line)
    end
  end

  def process_instructions(instructions)
    instructions.each do |instruction|
      account = @account_collection.register(instruction[:name])
      execute_instruction(account, instruction)
    end
  end

  def execute_instruction(account, instruction)
    if instruction[:command] == 'add'
      account.increase_limit(instruction[:amount])
      account.assign_card(instruction[:card]) if instruction[:card]
    elsif instruction[:command] == 'charge' || instruction[:command] == 'credit'
      transaction_collection.register_transaction(account:, amount: instruction[:amount],
                                                  type: instruction[:command])
    else
      puts 'Invalid command'
    end
  end
end
