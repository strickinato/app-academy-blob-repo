def stock_picker(arr)
  max_difference = 0
  return_arr = []
  
  arr.each_with_index do |val1, ind1|
    arr.each_with_index do |val2, ind2|
      if ind2 > ind1
        temp = arr[ind1..ind2].reduce(:+)
        if temp > max_difference
          max_difference = temp
          return_arr[0] = ind1
          return_arr[1] = ind2 
        end
      end 
    end
  end
  
  return_arr
end


stocks = [101, 50, 21, -200, 100, -30]

puts stock_picker(stocks).inspect