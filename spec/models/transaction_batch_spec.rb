# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionBatch do
  let(:batch_string) do
    'Add Tom 4111111111111111 $1000
        Add Lisa 5454545454545454 $3000
        Add Quincy 1234567890123456 $2000
        Charge Tom $500
        Charge Tom $800
        Charge Lisa $7
        Credit Lisa $100
        Credit Quincy $200'
  end

  let(:subject) { described_class.new(batch_string) }

  describe '#initialize' do
    it 'returns a TransactionBatch object with transactions attribute' do
      expect(subject).to be_a(TransactionBatch)
      expect(subject.transaction_collection).to be_a(TransactionCollection)
      expect(subject.transaction_collection.transactions).to be_a(Array)
      expect(subject.account_collection).to be_a(AccountCollection)
      expect(subject.account_collection.accounts).to be_a(Array)
    end

    it 'returns a account balances' do
      expect(subject.accounts_balances).to be_a(Array)
    end
  end
end
