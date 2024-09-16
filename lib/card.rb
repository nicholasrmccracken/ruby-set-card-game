# frozen_string_literal: true

module Game
  # Represents a card in the game of set.
  #
  # @attr_reader card_properties [Array<String, Integer>] The properties of the card, 
  #   These include color, symbol, number, and shading.
  class Card
    attr_reader :card_properties
  
    # Initializes a new Card.
    #
    # @param color [String] The color of the card. Could be 'r', 'g', or 'b'.
    # @param symbol [String] The symbol on the card. Could be 'o', 's', or 'd'.
    # @param number [Integer] The number of symbols on the card. Could be 1, 2, or 3.
    # @param shading [String] The shading of the symbols on the card. Could be 's', 'p' or 'o'.
    def initialize(color, symbol, number, shading)
      valid_color, valid_symbol, valid_number, valid_shading = %w[r g b], %w[o s d], [1, 2, 3], %w[s p o]

      unless valid_color.include?(color) && 
          valid_symbol.include?(symbol) &&
          valid_number.include?(number) && 
          valid_shading.include?(shading)
        raise ArgumentError, "Invalid card properties."
      end

      @card_properties = [color, symbol, number, shading]
    end

    # Checks if three cards form a set.
    #
    # @param card1 [Card] The first card.
    # @param card2 [Card] The second card.
    # @param card3 [Card] The third card.
    # @return [Boolean] True if the cards form a set, false otherwise.
    def self.set?(card1, card2, card3)
      card1.card_properties.each_with_index.all? do |property, i|
        [property, card2.card_properties[i], card3.card_properties[i]].uniq.length != 2
      end
    end

    # Returns a string representation of the card.
    # The string is in the format: color-symbol-number-shading.
    #
    # @return [String] The string representation of the card.
    def format_card
      "#{color_code}#{@card_properties[0]}-" \
      "#{@card_properties[1]}-" \
      "#{@card_properties[2]}-" \
      "#{@card_properties[3]}\e[0m"
    end

    private

    # Determines the ANSI color code based on the card's color property.
    # The color code is determined by the first property of the card, which represents the color.
    #
    # @return [String] The ANSI color code corresponding to the card's color.
    def color_code
      case @card_properties[0]
      when 'r'
        "\e[31m"
      when 'g'
        "\e[32m"
      when 'b'
        "\e[34m"
      else
        "\e[0m"
      end
    end
  end
end
