class Array
  def my_each
    self.length.times do |n|
       yield(self[n])
    end
    return self
  end
end

return_value = [1, 2, 3, 4, 5].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end