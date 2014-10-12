class Array
  def my_uniq
    new_array = []

    self.each do |item|
      new_array << item unless new_array.include?(item)
    end
    
    new_array
  end
end

isis = [1, 2, 3, 2]

puts isis.my_uniq.inspect
p isis.my_uniq
