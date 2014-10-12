def merge_sort(array)
  return array if array.length < 2
  
  array_one = array[0...(array.length / 2)]
  array_two = array[(array.length / 2 + 1)...array.length]
  
  merge(merge_sort(array_one), merge_sort(array_two))
end

def merge(arr1, arr2)
  new_array = []
  
  until arr1.empty? || arr2.empty?
    if arr1.first < arr2.first
      new_array << arr1.shift
    else
      new_array << arr2.shift
    end
  end
  new_array + arr1 + arr2
  # if arr1.empty?
  #   new_array + arr2
  # else
  #   new_array + arr1
  # end
end

array = (1..100).to_a.shuffle
print "Array: "
p array
print "Sorted: "
p merge_sort(array)
