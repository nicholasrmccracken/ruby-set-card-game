# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'board'
require_relative 'player'
require_relative 'game'
class CLI
  # start menu
  # first thing to run in the program
  # prints out welcome message to user and recieves input for which mode
  # the user wishes to play
  def start
    # output the opening message
    intro = File.read('resources/intro.txt')
    puts intro

    choice = 1
    while choice != 0
      # give and recieve game option
      options = File.read('resources/options.txt')
      puts options

      # cut input into integer
      input = gets.chomp
      choice = input.to_i

      # game cases
      case choice
      # exit condition
      when 0
        puts "Its been fun seeing you !!\n"
      # play mode
      when 1
        play
      # rules mode
      when 2
        rules
      # programmer notes
      when 3
        puts 'notes to come'
      # invalid input condition
      else
        puts "error: #{choice} is a non valid input, try again"
      end

    end
  end

  def play
    puts 'Enter # of players: '
    n_players = gets.to_i
    if n_players < 1
      puts 'At least one player required.'
      return
    end

    players = []
    n_players.times { |i| players << Game::Player.new("Player #{i + 1}") }

    board = Game::Board.new(Game::Deck.new(Game::Card))

    game = Game::SetGame.new(board, players)
    puts 'Starting game...'
    game.play_game
  end

  # Defines the rules of the game
  def rules
    exit = 0
    # exit loop when user is done reading rules
    while exit != 1
      # output and read options for rules explaination
      puts '---------------------------------------------------------------------------'
      puts "What would you like to further explore\n1: display\n2: how to read features\n3: how to make a set\n0: back to menu\n"
      input = gets.chomp
      option = input.to_i

      case option
      # case for display
      when 1
        puts 'the format of the dispay is as follows:'
        puts "% 1 2 3 4\n0 _ _ _ _\n1 _ # _ _\n2 _ _ _ _"
        puts 'the users will adress each card as follows'
        puts 'to index # user inputs location (1, 2)'
      # cae for features
      when 2
        puts 'features are displayed as follows'
        puts '[NumberColor-ShapeShade]'
        puts "Number: 1 2 or 3, Color: r g or b, Shape: oval sqiggle diamond,\nShade: none, partial, full"
      # case for set
      when 3
        puts 'Set = 3 cards whose feature is EITHER the same or DIFFERENT on each card'
        puts "this means any feature in the set is either\nCommon to all 3\nor Different in all 3"
      # exit condition
      when 0
        exit = 1
      # invalid input condition
      else
        puts "Error, input of #{option} is not a choice\n"
      end
    end
  end
end

# Run game.
cli = CLI.new
cli.start
