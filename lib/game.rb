#Handles the core logic and flow of the game. Initialize the game, manage turns, check for sets, etc.

require_relative 'deck'
require_relative 'rules'

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
    
 #2 player mode
  when 2
    
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



