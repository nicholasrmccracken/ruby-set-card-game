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
    def shuffle!
      @deck.shuffle!
    end

    # Deals a specified number of cards from the deck.
    #
    # @param n [Integer] The number of cards to deal. Defaults to 1.
    # @return [Array<Card>] The dealt cards.
    def deal_cards(num_cards = 1)
      cards = []
      num_cards.times do
        cards.push(@deck.pop)
      end
      cards
    end

    # Replace a found set with 3 new cards
    #
    # @param set [Array<Card>] The cards in the found set.
    # @param cards [Array<Card>] The current cards visible to player.
    # @return [Array<Card>] New updated array of cards.
    def replace_set(set, cards)
      set.each { |card| cards.delete(card) }
      cards.concat(deal_cards(3))
    end

    # Add 3 new cards to those visible to player.
    #
    # @param cards [Array<Card>] The current cards visible to player.
    # @return [Array<Card>] New updated array of cards.
    def add_more_cards(cards)
      cards.concat(deal_cards(3))
    end
  end
end
