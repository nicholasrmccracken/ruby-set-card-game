#Handles the core logic and flow of the game. Initialize the game, manage turns, check for sets, etc.
# frozen_string_literal: true
require_relative 'deck'
require_relative 'card'

module Game
  #Represents a game playthrough of set
  class Game

    #creates a new deck of cards
    #initializes the deck
    #shuffles the deck
    #adds 12 cards to the board
    def initialize 
      @deck = Deck.new
      @deck.shuffle!
      @board = @deck.deal_cards(12)
    end

    #start menu
    #first thing to run in the program
    #prints out welcome message to user and recieves input for which mode 
      #the user wishes to play
    def start
      #output the opening message
      intro = File.read('intro.txt')
      puts intro


      choice = 1
      while choice != 0
        #give and recieve game option
        options = File.read('options.txt')
        puts options
  
        #cut input into integer
        input = gets.chomp
        choice = input.to_i
  
        #game cases
        case choice
      #exit condition
        when 0
          puts "Its been fun seeing you !!\n"
      #single player mode
        when 1
          single_player
      #2 player mode
        when 2
          two_player
      #rules mode   
        when 3
          rules
      #programmer notes
        when 4
          puts "notes to come"
      #invalid input condition
        else 
          puts "error: #{choice} is a non valid input, try again"
        end
   
      end
    end
    
    #code for single player mode
    #only requires keeping track of one users input
    def single_player

    end

    #code for 2 player mode
    #same as single player but users can enter in how many players will be there
    #users must first enter in player number before typing set
    def two_player

    end

   # Defines the rules of the game
    def rules
      exit = 0
      #exit loop when user is done reading rules
      while exit != 1
      #output and read options for rules explaination
      puts "---------------------------------------------------------------------------"
      puts "What would you like to further explore\n1: display\n2: how to read features\n3: how to make a set\n0: back to menu\n"
      input = gets.chomp
      option = input.to_i


       case option
      #case for display
       when 1
       puts "the format of the dispay is as follows:"
       puts "% 1 2 3 4\n0 _ _ _ _\n1 _ # _ _\n2 _ _ _ _"
       puts "the users will adress each card as follows"
       puts "to index # user inputs location (1, 2)"
      #cae for features
       when 2
       puts "features are displayed as follows"
       puts "[NumberColor-ShapeShade]"
       puts "Number: 1 2 or 3, Color: r g or b, Shape: oval sqiggle diamond,\nShade: none, partial, full"
      #case for set
       when 3
       puts "Set = 3 cards whose feature is EITHER the same or DIFFERENT on each card"
       puts "this means any feature in the set is either\nCommon to all 3\nor Different in all 3"
     #exit condition
       when 0
       exit = 1
     #invalid input condition
       else
       puts "Error, input of #{option} is not a choice\n"
      end
    end
  end

  #this function prints to screen the full deck of 12 random cards. it
  #prints a "coordinate system" along with them
  #REQUIRES: a full deck of 12 cards
  #RETURNS: nothing
  def print_deck
    indexing = ["0","1","2"]
    count = 1
    #Printing strings to screen

      #prints horizontal coordinates for user to input card
    for j in 0..3
      print "      #{j}"
    end

    #prints first vertical coordinate
    puts ""
    print "0 "

    @board.each_with_index do |card, i|
      print card.format_card
      if i != 0 && i %4 ==3
        puts ""
        print "#{indexing[count]} "
        count +=1
      end
    end
  end

  #this function is designed to create and return an array of size 3.
  #it will contain the 3 cards the user wishes to check against the rules
  #to validate a set.
  #REQUIRES: a deck of cards of any size
  #RETURNS: array of size 3
  #TO DO: possibly add a loop asking if the user is satisfied with the set or
  #would like to change their choice, as well as maybe adding error checks when the user is inputing a card
  def get_trio 
    puts "Enter 3 cards to make a set\n\nYou will enter row then column"
    
    3.times do 
      print "Enter the row: "
      row = gets.chomp.to_i

      print "Enter the column: "
      column = gets.chomp.to_i

      trio << @board[row * 4 + column]
    end
    
    puts "verifying set between cards...\n"
    3.times {|n| print "#{trio[n]} | "}

    return trio
  end  
  end
end

