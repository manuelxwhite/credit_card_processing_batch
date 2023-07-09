# frozen_string_literal: true

class Transaction
  attr_reader :account, :amount, :type, :status, :id

  TRANSACTION_TYPES = %w[credit charge].freeze
  TRANSACTION_STATUS = %w[applied rejected].freeze

  def initialize(account, amount, type, status = 'applied')
    @account = account
    @amount = amount
    @type = type
    @status = status

    @id = SecureRandom.uuid
  end

  def valid?
    TRANSACTION_TYPES.include?(@type) && @amount.positive? && !@account.blocked? && TRANSACTION_STATUS.include?(@status)
  end
end
