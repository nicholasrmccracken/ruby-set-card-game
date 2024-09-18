# frozen_string_literal: true

require_relative 'utils'
require_relative 'card'
require_relative 'deck'
require_relative 'board'
require_relative 'player'
require_relative 'game'

# Handles user interaction for the game.
# Provides menu, rules, and other options.
class CLI
  # Displays the start menu and handles the user's choice of game mode.
  # User can choose to start a game, view the rules, or exit the program.
  def start_program
    puts File.read('resources/intro.txt')

    actions = { 1 => -> { start_game },
                2 => -> { rules },
                3 => -> { exit_program } }

    loop do
      puts File.read('resources/menu_options.txt')
      choice = gets.chomp.to_i
      Game.perform_action(actions, choice)
    end
  end

  # Starts a new game.
  # Asks users for number of players, creates necessary game objects, and runs game loop.
  def start_game
    return if (difficulty = initialize_difficulty) == -1
    return if (player_count = initialize_player_count) == -1
    return if (winning_score = initialize_winning_score(player_count)) == -1

    puts

    players = initialize_players(player_count)

    board = Game::Board.new(Game::Deck.new(Game::Card))
    game = Game::SetGame.new(board, players, difficulty, winning_score)

    game.play_game
  end

  # Initializes the difficulty level for the game.
  #
  # @return [String, Integer] The difficulty level if valid, -1 otherwise.
  def initialize_difficulty
    print "\nEnter difficulty of easy, medium, or hard: "
    difficulty = gets.chomp
    unless %w[easy medium hard].include?(difficulty)
      puts "#{difficulty} was an invalid difficulty."
      return -1
    end
    difficulty
  end

  # Initializes the number of players for the game.
  #
  # @return [Integer] The number of players if valid, -1 otherwise.
  def initialize_player_count
    print "\nEnter # of players: "
    player_count = gets.chomp.to_i
    if player_count < 1
      puts 'At least one player is required.'
      return -1
    end
    player_count
  end

  # Initializes the winning score for the game.
  #
  # @param player_count [Integer] The number of players.
  # @return [Integer] The winning score if valid, -1 otherwise.
  def initialize_winning_score(player_count)
    print "\nEnter winning score: "
    winning_score = gets.chomp.to_i
    unless (1..(Game::MAX_SETS / player_count)).include?(winning_score)
      puts "Winning score must be at least 1 and less than #{Game::MAX_SETS / player_count}"
      return -1
    end
    winning_score
  end

  # Initializes an array of Player objects.
  #
  # @param player_count [Integer] The number of players to initialize.
  # @return [Array<Game::Player>] An array of Player objects.
  def initialize_players(player_count)
    players = []
    player_count.times do |i|
      print "Enter player #{i + 1}'s name: "
      players << Game::Player.new(gets.chomp)
      puts
    end
    players
  end

  # Displays the rules menu and provides explanations for how the game works.
  def rules
    actions = { 1 => -> { puts File.read('resources/rules.txt') },
                2 => -> { puts File.read('resources/properties.txt') },
                3 => -> { puts File.read('resources/set_definition.txt') },
                4 => -> {} }

    loop do
      print_rules_menu
      choice = gets.chomp.to_i

      Game.perform_action(actions, choice)
      break if choice == 4
    end
  end

  # Prints the rules menu with each of the user selectable options.
  def print_rules_menu
    puts File.read('resources/rules_menu.txt')
  end

  # Exits the program with a goodbye message.
  def exit_program
    puts "It's been fun seeing you!"
    exit
  end
end

# Run game.
cli = CLI.new
cli.start_program
