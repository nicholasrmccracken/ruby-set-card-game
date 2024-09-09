#Initialize the array with 12 elements (will be randomized, only filled for now for testing
cards = ["{1b-sn}","{2r-op}","{3g-df}","{1g-sf}","{3r-sd}","{00-00}","{00-00}","{00-00}","{00-00}","{00-00}","{00-00}","{00-00}"];
indexing = ["A","B","C"]
count = 1
#Printing strings to screen
for j in 1..4
  print "   #{j}   "
end
puts ""
print "A "
for i in 0..12
  print cards[i]
  if i != 0 && i%4 == 0
    puts ""
    print indexing[count]
    print " " 
    count += 1
  end   
end


