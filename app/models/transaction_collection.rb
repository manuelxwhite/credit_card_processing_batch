# frozen_string_literal: true

class TransactionCollection
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def register_transaction(account:, amount:, type:)
    return if account.blocked?

    transaction_status = available_funds?(account, amount) ? 'applied' : 'rejected'
    transaction = Transaction.new(account, amount, type, transaction_status)
    @transactions << transaction unless account.blocked?
    transaction
  end

  def balance(name)
    account = find_account(name)

    total_charge_transactions(account) - total_credit_transactions(account)
  end

  def available_funds?(account, amount)
    amount <= limit_available(account)
  end

  private

  def total_credit_transactions(account)
    credit_transactions_by_account_id(account&.id).sum(&:amount) || 0
  end

  def total_charge_transactions(account)
    charge_transactions_by_account_id(account&.id).sum(&:amount) || 0
  end

  def limit_available(account)
    account.limit - balance(account.account_owner)
  end

  def find_account(name)
    @transactions.find { |transaction| transaction.account.account_owner == name }&.account
  end

  def credit_transactions_by_account_id(account_id)
    @transactions.select do |transaction|
      transaction.account.id == account_id &&
        transaction.type == 'credit' &&
        transaction.valid? &&
        transaction.status == 'applied'
    end
  end

  def charge_transactions_by_account_id(account_id)
    @transactions.select do |transaction|
      transaction.account.id == account_id &&
        transaction.type == 'charge' &&
        transaction.valid? &&
        transaction.status == 'applied'
    end
  end

  def find_by_name(name)
    @transactions.select { |transaction| transaction.account.account_owner == name }
  end

  def account_transactions(account)
    @transactions.select { |transaction| transaction.account == account }
  end
end
