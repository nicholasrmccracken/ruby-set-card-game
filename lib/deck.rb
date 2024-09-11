# frozen_string_literal: true

require_relative 'card'

module Game
  # Represents a collection of cards as a deck.
  #
  # @attr_reader deck [Array<Card>] The array of cards in the deck.
  class Deck
    attr_reader :deck

    # Initializes a new Deck.
    #
    # @return [Deck] The newly created Deck.
    def initialize
      colors = %w[r g b]
      symbols = %w[o s d]
      numbers = [1, 2, 3]
      shadings = %w[s p o]

      @deck = colors.product(symbols, numbers, shadings).map do |color, symbol, number, shading|
        Game::Card.new(color, symbol, number, shading)
      end
    end

    # Shuffles the deck in-place.
    #
    # @return [Array<Card>] The shuffled deck.
    def shuffle_deck!
      @deck.shuffle!
    end

    # Deals a specified number of cards from the deck.
    #
    # @param n [Integer] The number of cards to deal. Defaults to 1.
    # @return [Array<Card>] The dealt cards.
    def deal_cards(n = 1)
      cards = []
      n.times do
        cards.push(@deck.pop)
      end
      cards
    end
  end
end
