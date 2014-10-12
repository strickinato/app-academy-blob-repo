load 'my_uniq.rb'

class Array
  def two_sum
    return_arr = []

    self.each_with_index do |value1, index1|
      self.each_with_index do |value2, index2|
        if value1 + value2 == 0 && index1 != index2
          return_arr << [index1, index2].sort!
        end
      end
    end

    return_arr.my_uniq
  end
end

aaron = [-1, 0, 2, -2, 1]

puts aaron.two_sum.inspect
