# frozen_string_literal: true

class Account
  attr_accessor :account_owner, :card, :limit, :id

  def initialize(account_owner, limit = 0)
    @account_owner = account_owner
    @limit = limit
    @id = SecureRandom.uuid
  end

  def blocked?
    @card.valid? ? false : true
  end

  def increase_limit(amount)
    @limit += amount
  end

  def assign_card(card_number)
    @card = Card.new(number: card_number)
  end
end
