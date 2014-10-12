def median(arr)
  sorted = arr.sort
  half = arr.length / 2
  
  if arr.length % 2 == 0
    arr[half..(half+1)].reduce(:+) / 2
  else
    arr[half]
  end
end

p median([5,7,3,6,3,5,6,4,2,2,4,566])
p median([785,7897,76,56,7,9,5])