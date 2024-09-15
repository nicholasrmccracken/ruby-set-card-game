# Defines the rules of the game, stores came constants, defines conditions.

def rules
  exit = 0
  #exit loop when user is done reading rules
  while exit != 1
    #output and read options for rules explaination
    puts "What would you like to further explore\n1: display\n2: how to read features\n3: how to make a set\n0: back to menu"
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
