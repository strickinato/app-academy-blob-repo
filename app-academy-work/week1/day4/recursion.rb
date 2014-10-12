def range_recursion(start, finish)
  return [] if start > finish
  
  range_recursion(start, finish - 1) << finish
end

def range_iteration(start, finish)
  new_array = []
  
  (finish - start + 1).times do |i|
    new_array << start + i
  end
  
  new_array
end

def exponentiation1(base, exponent)
  return 1 if exponent == 0
  base * exponentiation1(base, exponent - 1)
end

def exponentiation2(base, exponent)
  return 1 if exponent == 0
  if exponent.even?
    exponentiation2(base, exponent / 2) ** 2
  else
    base * exponentiation2(base, (exponent - 1) / 2) ** 2
  end
end

def deep_dup(item)
  return item unless item.is_a?(Array)
  
  array = []
  item.each do |el|
    array << deep_dup(el)
  end
    
  array
end

def fibonacci_recursive(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  
  fibs = fibonacci_recursive(n-1)
  fibs << fibs[-1] + fibs[-2]
  fibs
end

def fibonacci_iterative(n)
  return [0] if n == 1
  
  arr = [0,1]
  until arr.length == n
    arr << arr[-1] + arr[-2]
  end
  
  arr
end


#Tests
p range_iteration(20,40)
p range_recursion(20,40)
p exponentiation1(2, 5)
p exponentiation2(- 2, 5)
p exponentiation2(- 2, 6)
p exponentiation2(2, 5)


robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy = deep_dup(robot_parts)

# shouldn't modify robot_parts
robot_parts_copy[1] << "LEDs"
# wtf?
p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
p robot_parts_copy[1]

p fibonacci_recursive(20)
p fibonacci_iterative(20)


