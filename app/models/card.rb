# frozen_string_literal: true

class Card
  attr_reader :number

  def initialize(number:)
    @number = number
  end

  def valid?
    return false if @number.nil? || @number.empty? || @number.chars.map(&:to_i).sum.zero?

    (card_digits_luhn_sum % 10).zero? ? true : false
  end

  private

  def card_digits_luhn_sum
    card_digits = @number.chars.map(&:to_i).reverse

    card_digits = card_digits.map.with_index do |digit, index|
      digit = digit.to_i
      if index.odd?
        digit *= 2
        digit -= 9 if digit > 9
      end
      digit
    end

    card_digits.sum
  end
end
