# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card do
  let(:card_number) { '1234567890123452' }

  let(:subject) { described_class.new(number: card_number) }

  describe '#valid?' do
    context 'when card number is invalid' do
      let(:card_number) { '1234567890123456' }
      it 'returns false ' do
        expect(subject.valid?).to eq(false)
        expect(subject.number).to eq(card_number)
      end
    end

    context 'when card number is valid' do
      it 'returns true if card number is valid' do
        expect(subject.valid?).to eq(true)
        expect(subject.number).to eq(card_number)
      end
    end
  end
end
