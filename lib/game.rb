# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'board'

module Game
  # Represents a game playthrough of set.
  class SetGame
    # Initialize a new SetGame.
    #
    # @param board [Board] the game board.
    # @param difficulty [Integer] the game difficulty.
    def initialize(board, difficulty)
      @board = board
      @difficulty = difficulty
    end

    # Play the game until the board is empty.
    def play_game
      play_round until @board.board.empty?
    end

    private

    # Play a round of the game. This includes printing the board,
    # getting the player's choice, and processing the player's choice.
    def play_round
      @board.print_board
      puts

      loop do
        choice = player_choice

        case choice
        when 'a'
          @board.add_cards
        when 'i'
          break if process_set_identification
        when 'h'
          process_hint
        else
          puts 'Invalid move. Please try again.'
        end
        @board.print_board
        puts
      end
    end

    # Get the player's choice for the current round.
    #
    # @return [String] the player's choice
    def player_choice
      puts '(a) Add 3 more cards'
      puts '(i) Identify set'
      puts '(h) See hint'
      print 'Enter choice: '
      gets.chomp
    end

    # Process the player's choice to identify a set.
    #
    # @return [Boolean] true if a set was identified, false otherwise
    def process_set_identification
      trio = get_trio
      if @board.board[trio[0]].set?(@board.board[trio[1]], @board.board[trio[2]])
        puts 'Set found!'
        @board.remove_cards(trio)
        @board.add_cards unless @board.board.length >= START_SIZE
        return true
      end

      puts 'Not a valid set.'
      false
    end

    # Process the player's request for a hint.
    def process_hint
      case @difficulty
      when 'easy'
        @board.find_single_set
        puts "Cards #{@board.find_single_set} make a set."
      when 'medium'
        puts "There are #{@board.find_set_count} sets on the board."
      when 'hard'
        puts 'No hints allowed.'
      end
    end

    # Get a trio of cards from the user
    #
    # @return [Array<Integer>] the trio of cards
    def get_trio
      iteration = %w[first second third]
      trio = []

      while trio.length < 3
        print "Enter #{iteration[trio.length]} row: "
        row = gets.chomp.to_i

        print "Enter #{iteration[trio.length]} column: "
        column = gets.chomp.to_i

        coordinate = row * 3 + column
        if !trio.include?(coordinate) && valid_coordinates?(row, column)
          trio.push(row * 3 + column)
        else
          puts 'Invalid row or column. Please try again.'
        end
        puts
      end
      trio
    end

    # Check if the given coordinates are valid
    #
    # @param row [Integer] the row coordinate
    # @param column [Integer] the column coordinate
    # @return [Boolean] true if the coordinates are valid, false otherwise
    def valid_coordinates?(row, column)
      row_count = @board.board.length / 3 - 1
      row_range = 0..row_count
      column_range = 0..2

      row_range.include?(row) && column_range.include?(column)
    end
  end
end
