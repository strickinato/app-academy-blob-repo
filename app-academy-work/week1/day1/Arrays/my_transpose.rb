def my_transpose(rows)

  transposed = [[],[],[]]
  
  rows.each_with_index do |num1, ind1|
    rows[ind1].each_with_index do |num2, ind2|
      transposed[ind1][ind2] = rows[ind2][ind1]
    end
  end
  transposed
end

example = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]
  
  
  puts my_transpose(example).inspect
