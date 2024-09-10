#Initialize the array with 12 elements (will be randomized, only filled for now for testing
cards = ["{1b-sn}","{2r-op}","{3g-df}","{1g-sf}","{3r-sd}","{00-00}","{00-00}","{00-00}","{00-00}","{00-00}","{00-00}","{00-00}"];

#this function prints to screen the full deck of 12 random cards. it
#prints a "coordinate system" along with them 
#REQUIRES: a full deck of 12 cards 
#RETURNS: nothing
#TO DO: nothing?
def print_deck(cards)
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

  #printing the deck of cards
  for i in 0..12
   print cards[i]
    #creates new row of cards at 4th 
     #as well as printing rest of vertical coordiantes 
   if i != 0 && i%4 == 3
    puts ""
    print indexing[count]
    print " " 
    count += 1
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
def get_trio(cards)
  #asking for user input
  puts "Enter 3 cards to make a set.\n"
  trio = ["","",""]
  
  for i in 0..2
   #reading input for card
   print "Enter the Row: "
   input = gets.chomp
   row = input.to_i

   print "\nEnter the column: "
   input = gets.chomp
   column = input.to_i

   #add card to trio list
   trio[i] = cards[row*4+column]

  end
  
  #print cards
  puts "Checking for set between cards,\n"
  3.times {|n| print "  #{trio[n]},"}
  
  #maybe ask if this is the set you want to pick???


  return trio
end

#calling functions for testing
print_deck(cards)

three = get_trio(cards)







