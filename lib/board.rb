# frozen_string_literal: true

require_relative 'constants'
require_relative 'card'
require_relative 'deck'

module Game
  # Represents the playing area where cards are dealt.
  #
  # @attr_reader board [Array<Card>] The cards on the board card.
  class Board
    attr_reader :board

    # Initializes a new board.
    #
    # @param deck [Deck] the deck of cards.
    def initialize(deck)
      @deck = deck
      @deck.shuffle!
      @board = deck.deal_cards(START_SIZE)
      @found_sets = []
      @sets = []
    end

    # Tracks the valid sets found.
    #
    # @param set [Array<Card>] the found set.
    # @return [Array<Array<Card>>] the list of sets found by the player.
    def track_found_sets(set)
      @found_sets << set
      put "#{@found_sets.size} sets found!"
    end

    # Adds new cards to those visible to the player.
    #
    # @param num_cards [Integer] the number of cards to add (default is 3).
    # @return [Array<Card>] the updated array of cards.
    def add_cards(num_cards = 3)
      @board.concat(@deck.deal_cards(num_cards))
    end

    # Removes cards from the board.
    #
    # @param trio [Array<Integer>] the indices of the cards to remove.
    def remove_cards(trio)
      trio.sort.reverse_each do |i|
        @board.delete_at(i)
      end
    end

    # Counts the number of sets on the board.
    #
    # @return [Integer] the number of sets.
    def find_set_count
      count = 0
      @board.combination(3).each do |card1, card2, card3|
        count += 1 if card1.set?(card2, card3)
      end
      count
    end

    # Finds a single set on the board.
    #
    # @return [String] the coordinates of the cards in the set.
    def find_single_set
      @board.each_with_index.to_a.combination(3).each do |(card1, idx1), (card2, idx2), (card3, idx3)|
        next unless card1.set?(card2, card3)

        return "(#{idx1.div(3)}, #{idx1 % 3}), (#{idx2.div(3)}, #{idx2 % 3}), (#{idx3.div(3)}, #{idx3 % 3})"
      end
    end

    # Prints the board to the console.
    def print_board
      print_col_nums

      rows = 0
      @board.each_with_index do |card, i|
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
