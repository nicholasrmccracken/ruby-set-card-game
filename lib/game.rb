# frozen_string_literal: true

require_relative 'constants'
require_relative 'card'
require_relative 'deck'
require_relative 'board'
require_relative 'player'

module Game
  # Represents a game playthrough of set.
  class SetGame
    # Initialize a new SetGame.
    #
    # @param board [Board] the game board.
    # @param players [Array<Player>] the players in the game.
    # @param difficulty [String] the game difficulty. Must be 'easy', 'medium', or 'hard'. Defaults to 'medium'.
    # @param winning_score [Integer] the score required to win the game. Must be <= MAX_SETS / number of players.
    #   Defaults to 5.
    # @raise [ArgumentError] if difficulty is not valid or if winning_score exceeds the allowed max.
    def initialize(board, players, difficulty = 'medium', winning_score = 5)
      @board = board
      @players = players

      unless %w[easy medium hard].include?(difficulty)
        raise ArgumentError, "Invalid difficulty '#{difficulty}'. Must be 'easy', 'medium', or 'hard'."
      end

      @difficulty = difficulty

      unless (1..(MAX_SETS / players.size)).include?(winning_score)
        raise ArgumentError, "Invalid winning score #{winning_score}. Must be between 1 and #{MAX_SETS / players.size}."
      end

      @winning_score = winning_score
    end

    # Play the game until the board is empty or a player wins.
    def play_game
      until @board.cards.empty?
        @players.each do |player|
          play_turn(player)

          if player.score >= @winning_score
            puts "#{player.name} has won with a score of #{player.score}!"
            return true
          end
        end
      end
    end

    private

    # Play a round of the game.
    #
    # @param player [Player] the player whose turn it is.
    def play_turn(player)
      loop do
        print_scoreboard
        @board.print_board
        puts

        print "#{player.name}'s turn:\n"
        break if process_choice(player_choice, player)
      end
    end

    # Print the scoreboard showing each player's score.
    def print_scoreboard
      puts ' ------ Scoreboard ------ '
      @players.each_with_index do |player, i|
        print "#{player.name}: #{player.score}"
        print ', ' if i < @players.length - 1
      end
      print "\n\n"
    end

    # Get the player's choice for the current round.
    #
    # @return [String] the player's choice
    def player_choice
      puts '(a) Add 3 more cards'
      puts '(i) Identify set'
      puts '(h) See hint'
      print 'Enter choice: '
      choice = gets.chomp
      puts
      choice
    end

    # Process the player's choice and execute the appropriate action.
    #
    # @param choice [String] the player's choice.
    # @param player [Player] the current player.
    # @return [Boolean] true if a valid choice was made, false otherwise.
    def process_choice(choice, player)
      actions = { 'a' => -> { @board.add_cards },
                  'i' => -> { process_set_identification(player) },
                  'h' => -> { process_hint } }

      if actions[choice]
        actions[choice].call
        true
      else
        print "Invalid move. Please try again.\n\n"
        false
      end
    end

    # Process the player's attempt to identify a set.
    #
    # @param player [Player] the current player.
    # @return [Boolean] true if the player correctly identified a set, false otherwise.
    def process_set_identification(player)
      trio = parse_trio
      if Game::Card.set?(@board.cards[trio[0]], @board.cards[trio[1]], @board.cards[trio[2]])
        process_valid_set(player, trio)
      else
        print "Not a valid set.\n\n"
      end
    end

    # Process a valid set identified by the player.
    #
    # @param player [Player] the current player.
    # @param trio [Array<Integer>] the indices of the cards that form a set.
    # @return [Boolean] always returns true
    def process_valid_set(player, trio)
      puts 'Set found!'
      player.increment_score
      @board.remove_cards(trio)
      @board.add_cards unless @board.cards.length >= START_SIZE
    end

    # Process the player's request for a hint. The hint provided depends on the game difficulty.
    def process_hint
      case @difficulty
      when 'easy'
        @board.find_single_set
        print "Cards #{@board.find_single_set} make a set.\n\n"
      when 'medium'
        print "There are #{@board.find_set_count} sets on the board.\n\n"
      when 'hard'
        print "No hints allowed.\n\n"
      end
    end

    # Get a trio of card indices from the user.
    #
    # @return [Array<Integer>] the indices of the trio of cards chosen by the player.
    def parse_trio
      iteration = %w[first second third]
      trio = []

      while trio.length < 3
        print "Enter #{iteration[trio.length]} row: "
        row = gets.chomp.to_i

        print "Enter #{iteration[trio.length]} column: "
        column = gets.chomp.to_i

        validate_trio(row, column, trio)
      end
      trio
    end

    # Validate the row and column entered by the player.
    #
    # @param row [Integer] the row entered by the player.
    # @param column [Integer] the column entered by the player.
    # @param trio [Array<Integer>] the current trio of card indices.
    def validate_trio(row, column, trio)
      coordinate = row * 3 + column
      if !trio.include?(coordinate) && valid_coordinates?(row, column)
        trio.push(coordinate)
      else
        puts 'Invalid row or column. Please try again.'
      end
      puts
    end

    # Check if the row and column are within the valid range of the board.
    #
    # @param row [Integer] the row index.
    # @param column [Integer] the column index.
    # @return [Boolean] true if the coordinates are valid, false otherwise.
    def valid_coordinates?(row, column)
      row_count = @board.cards.length / 3 - 1
      row_range = 0..row_count
      column_range = 0..2

      row_range.include?(row) && column_range.include?(column)
    end
  end
end

# Run game in debug mode.
if __FILE__ == $0
  game = Game::SetGame.new(
    Game::Board.new(Game::Deck.new(Game::Card)),
    [Game::Player.new('Johnston'), Game::Player.new('Jonothy')],
    'easy', 1
  )
  game.play_game
end
