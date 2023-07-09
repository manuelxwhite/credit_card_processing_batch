# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction do
  let(:account_owner) { 'John Doe' }
  let(:card_number) { '1234567890123452' }
  let(:card) { Card.new(number: card_number) }
  let(:account) { Account.new(account_owner, card) }
  let(:amount) { 100 }
  let(:type) { 'credit' }
  let(:status) { 'approved' }

  let(:subject) { described_class.new(account, amount, type) }

  describe '#initialize' do
    context 'with a valid transaction type and amount' do
      it 'returns a Transaction object with account_id, amount, type and id attributes' do
        expect(subject).to be_a(Transaction)
        expect(subject.account).to eq(account)
        expect(subject.amount).to eq(amount)
        expect(subject.type).to eq(type)
        expect(subject.id).to be_a(String)
      end
    end

    context 'with an invalid transaction' do
      let(:type) { 'invalid' }
      it 'sets as invalid' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'with an invalid amount' do
      let(:amount) { 0 }
      it 'sets as invalid transaction' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'with an account with invalid card number and blocked account' do
      let(:card_number) { '3333333333333333' }

      before do
        account.assign_card(card_number)
      end
      it 'sets as invalid transaction' do
        expect(subject.account.blocked?).to eq(true)
      end
    end
  end
end
