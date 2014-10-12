class Array
  def my_each
    new_array = self
    
    self.length.times do |item|
      yield(new_array[item])
    end
  end
  
  def my_map
    new_array = []
    
    self.length.times do |item|
      new_array << yield(self[item])
    end
    
    new_array
  end
  
  def my_select
    new_array = []
    
    self.length.times do |item|
      new_array << item if yield(item)
    end
    
    new_array
  end
  
  def my_inject(num = 0)
    new_array = self
    accumulator = num
    
    self.my_each do |item|
      accumulator = yield(accumulator, item)
    end
  
    accumulator
  end
  
  def my_sort!

    (0...self.length - 1).each do |x|
      (x+1...self.length).each do |y|
        if  yield( self[x], self[y] ) == 1
          self[x], self[y] = self[y], self[x]
        end
      end
    end
    self
  end
  
  def my_sort(&prc)
    self.dup.my_sort! &prc
  end
  
end
