# frozen_string_literal: true

require_relative 'card'

module Game
  # Represents a collection of cards as a deck.
  class Deck
    # Initializes a new Deck.
    #
    # @param card_class [Class] The class to use for creating new cards.
    def initialize(card_class)
      colors = %w[r g b]
      symbols = %w[o s d]
      numbers = [1, 2, 3]
      shadings = %w[s p o]

      @deck = colors.product(symbols, numbers, shadings).map do |color, symbol, number, shading|
        card_class.new(color, symbol, number, shading)
      end
    end

    # Shuffles the deck in-place.
    #
    # @return [Array<Card>] The shuffled deck.
    def shuffle!
      @deck.shuffle!
    end

    # Deals a specified number of cards from the deck.
    #
    # @param n [Integer] The number of cards to deal. Defaults to 1.
    # @return [Array<Card>] The dealt cards.
    def deal_cards(num_cards = 1)
      cards = []
      [num_cards, @deck.length].min.times do
        cards.push(@deck.pop)
      end
      cards
    end
  end
end
