# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account do
  let(:account_owner) { 'John Doe' }
  let(:card_number) { '1234567890123452' }

  let(:card) { Card.new(number: card_number) }

  let(:subject) { described_class.new(account_owner) }

  describe '#initialize' do
    context 'with a valid card' do
      it 'returns an Account objec with account_owner and card_number and id attributes' do
        subject.assign_card(card_number)
        expect(subject).to be_a(Account)
        expect(subject.account_owner).to eq(account_owner)
        expect(subject.card).to be_a(Card)
        expect(subject.id).to be_a(String)
        expect(subject.blocked?).to eq(false)
      end
    end

    context 'with an invalid card' do
      let(:card_number) { '000000000000000' }
      it 'sets blocked? to true' do
        subject.assign_card(card_number)
        expect(subject.blocked?).to eq(true)
      end
    end
  end
end
