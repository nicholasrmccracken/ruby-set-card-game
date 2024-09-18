# frozen_string_literal: true

require_relative 'utils'
require_relative 'card'
require_relative 'deck'

module Game
  # Represents the playing area where cards are dealt.
  #
  # @attr_reader board [Array<Card>] The cards on the board card.
  class Board
    attr_reader :cards

    # Initializes a new board.
    #
    # @param deck [Deck] the deck of cards.
    def initialize(deck)
      @deck = deck
      @deck.shuffle!
      @cards = deck.deal_cards(Game::START_SIZE)
    end

    # Appends the given number of cards to the current array of visible cards.
    #
    # @param num_cards [Integer] the number of cards to add (default is 3).
    # @return [Array<Card>] the updated array of cards.
    def add_cards(num_cards = 3)
      @cards.concat(@deck.deal_cards(num_cards))
    end

    # Removes cards from the board.
    #
    # @param trio [Array<Integer>] the indices of the cards to remove.
    def remove_cards(trio)
      trio.sort.reverse_each do |i|
        @cards.delete_at(i)
      end
    end

    # Counts the number of sets on the board.
    #
    # @return [Integer] the valid number of sets on the board.
    def find_set_count
      count = 0
      @cards.combination(3).each do |card1, card2, card3|
        count += 1 if Game::Card.set?(card1, card2, card3)
      end
      count
    end

    # Finds a single set on the board.
    #
    # @return [String, nil] the coordinates of the cards in the set or nil if no set is found.
    def find_single_set
      @cards.each_with_index.to_a.combination(3).each do |(card1, idx1), (card2, idx2), (card3, idx3)|
        next unless Game::Card.set?(card1, card2, card3)

        return "(#{idx1.div(3)}, #{idx1 % 3}), (#{idx2.div(3)}, #{idx2 % 3}), (#{idx3.div(3)}, #{idx3 % 3})"
      end
      nil
    end

    # Prints the board to the console.
    # Cards are displayed in a grid format with rows and columns.
    def print_board
      print_col_nums

      rows = 0
      @cards.each_with_index do |card, i|
        if (i % 3).zero?
          print "#{rows} "
          rows += 1
        end

        print "#{card.format_card} "
        print "\n" if i % 3 == 2
      end
    end

    private

    # Prints the column numbers to the console.
    def print_col_nums
      3.times do |j|
        print "     #{j}  "
      end
      puts ''
    end
  end
end
