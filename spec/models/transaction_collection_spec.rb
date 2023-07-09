# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionCollection do
  let(:account_owner) { 'John Doe' }
  let(:card_number) { '1234567890123452' }
  let(:limit) { 1000 }
  let(:card) { Card.new(number: card_number) }
  let(:account) { Account.new(account_owner, limit) }

  let(:amount) { 100 }
  let(:type) { 'credit' }
  let(:status) { 'applied' }

  let(:transaction) { Transaction.new(account, amount, type) }

  let(:subject) { described_class.new }

  before do
    account.assign_card(card_number)
  end

  describe '#initialize' do
    it 'returns an TransactionCollection object with transactions attribute' do
      expect(subject).to be_a(TransactionCollection)
      expect(subject.transactions).to be_a(Array)
    end
  end

  describe '#register_transaction' do
    context 'when account exists' do
      it 'register a new transaction' do
        expect { subject.register_transaction(account:, amount:, type:) }.to change {
                                                                               subject.transactions.count
                                                                             }.by(1)
      end
    end
  end

  describe '#total_credit_by_account' do
    let(:existing_type) { 'charge' }
    let(:existing_amount) { 7 }
    before do
      subject.register_transaction(account:, amount: existing_amount, type: existing_type)
    end
    context 'when account exists' do
      it 'returns balance' do
        subject.register_transaction(account:, amount:, type:)
        expect(subject.balance(account_owner)).to eq(existing_amount - amount)
      end
    end
  end

  describe '#available_funds?' do
    it 'returns true if account has available funds' do
      subject.register_transaction(account:, amount:, type:)
      expect(subject.available_funds?(account, amount)).to eq(true)
    end
  end
end
