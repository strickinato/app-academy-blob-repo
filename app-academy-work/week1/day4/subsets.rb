def subsets(arr)
  if arr.empty? return [[]]
  
    arr.each_with_index do |n, i|
      
      subsets(arr) << 
    end
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])