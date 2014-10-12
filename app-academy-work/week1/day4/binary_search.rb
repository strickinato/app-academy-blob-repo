def b_search(arr, target, left = 0, right = (arr.length - 1))
  
  return nil if left > right
  middle = (left + right) / 2

  if arr[middle] > target
    b_search(arr, target, left, middle - 1)
  elsif arr[middle] < target
    b_search(arr, target, middle + 1, right)
  else
    middle
  end
  
end

array = (1..10000).to_a
#p b_search(array, 4)
# p b_search(array, 5)
p b_search(array, 576)
# p b_search(array, 10)




