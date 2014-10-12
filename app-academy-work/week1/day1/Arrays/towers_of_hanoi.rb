def towers_of_hanoi
  @tower1 = [3,2,1]
  @tower2 = []
  @tower3 = []
  @solution = [3,2,1]
  
  while @tower3 != @solution
    assignment = false
    while assignment == false
      print "Where do you want to take a disc from? (1,2,3)"
      choice1 = gets.chomp
      origin_tower = assign_tower(choice1)
      if origin_tower.empty?
        puts "not a valid choice"
      else
        assignment = true
      end
    end
        
    print "Where do you want to put the disc? (1,2,3)"
    choice2 = gets.chomp
    destination_tower = assign_tower(choice2)
    
    current_disc = origin_tower.pop
    
    if destination_tower.empty? || current_disc < destination_tower.last
      destination_tower.push(current_disc)
    else
      origin_tower.push(current_disc)
      puts "You can't put it there!"
    end
  
    puts @tower1.inspect
    puts @tower2.inspect
    puts @tower3.inspect 
  end
  puts "You're a genius!! Good job!"
end

def assign_tower(str)
  if str == "1"
    tower = @tower1
  elsif str == "2"
    tower = @tower2
  elsif str == "3"
    tower = @tower3
  else
    puts "meow"
  end
  
  tower
end

towers_of_hanoi
