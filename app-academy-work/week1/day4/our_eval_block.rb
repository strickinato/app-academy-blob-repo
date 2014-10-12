def eval_block(*args)
  if block_given?
    p yield(*args)
  else
    puts "NO BLOCK GIVEN"
  end
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end

eval_block("Kerry", "Washington", 23)

eval_block(1,2,3,4,5) do |*args|
  args.inject(:+)
end