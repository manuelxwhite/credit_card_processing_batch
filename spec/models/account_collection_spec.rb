# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountCollection do
  let(:account_owner) { 'John Doe' }
  let(:card_number) { '1234567890123452' }
  let(:limit) { 1000 }

  let(:subject) { described_class.new }

  describe '#initialize' do
    it 'returns an AccountCollection object with accounts attribute' do
      expect(subject).to be_a(AccountCollection)
      expect(subject.accounts).to be_a(Array)
    end
  end

  describe '#register_account' do
    context 'when account does not exist' do
      it 'registers an account' do
        expect { subject.register(account_owner, limit) }.to change { subject.accounts.count }.by(1)
      end
    end

    context 'when account exists' do
      before do
        subject.register(account_owner, limit)
      end

      it 'does not register an account' do
        subject.register(account_owner, limit)
        expect(subject.accounts.count).to eq(1)
      end
    end
  end

  describe '#find_account' do
    context 'when account exists' do
      let(:card_number) { '1234567890123452' }
      let(:account_owner) { 'John Doe' }
      before do
        subject.register(account_owner, limit)
      end
      it 'returns an account' do
        expect(subject.find_account(account_owner)).to be_a(Account)
      end
    end

    context 'when account does not exist' do
      it 'returns nil' do
        expect(subject.find_account(card_number)).to eq(nil)
      end
    end
  end

  describe '#increase_limit' do
    let(:card_number) { '1234567890123452' }
    let(:account_owner) { 'John Doe' }
    let(:limit) { 1000 }
    let(:new_limit) { 2000 }

    before do
      subject.register(account_owner, limit)
    end

    it 'increases limit' do
      account = subject.find_account(account_owner)
      expect { account.increase_limit(new_limit) }.to change {
                                                        subject.find_account(account_owner).limit
                                                      }.from(limit).to(limit + new_limit)
    end
  end

  describe '#assign_card' do
    it 'assigns a card to an account' do
      subject.register(account_owner, limit)
      account = subject.find_account(account_owner)
      expect { account.assign_card(card_number) }.to change {
                                                       subject.find_account(account_owner).card&.number
                                                     }.from(nil).to(card_number)
    end
  end
end
