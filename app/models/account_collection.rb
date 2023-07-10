# frozen_string_literal: true

class AccountCollection
  attr_accessor :accounts

  def initialize
    @accounts = []
  end

  def register(name, limit = 0)
    account = find_or_create_account(name)
    increase_limit(name, limit)
    account
  end

  def find_account(name)
    @accounts.find { |account| account.account_owner == name }
  end

  def increase_limit(name, amount)
    account = find_account(name)
    account.limit += amount
  end

  def assign_card(card_number, account)
    account.card.assign_card(card_number)
  end

  private

  def find_or_create_account(name)
    account = find_account(name)
    if account.nil?
      account = Account.new(name)
      @accounts << account
    end
    account
  end

  def exists?(card_number)
    find_account(card_number) != nil
  end
end
