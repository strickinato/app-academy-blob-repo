def num_to_s(num, base)
  n = 0
  print_arr = []
  letters = %w[A B C D E F]
  while true
    break if (base ** n) > num
    next_digit = (num / base ** n) % base
    if next_digit > 9
      next_digit = letters[next_digit - 10]
    end
    print_arr << next_digit
    n = n + 1
  end
  print_arr.reverse.join('')
end


puts num_to_s(5, 10) #=> "5"
puts num_to_s(5, 2)  #=> "101"
puts num_to_s(5, 16) #=> "5"

puts num_to_s(234, 10) #=> "234"
puts num_to_s(234, 2)  #=> "11101010"
puts num_to_s(234, 16) #=> "EA"