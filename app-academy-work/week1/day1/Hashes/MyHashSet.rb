class MyHashSet
  attr_accessor :store
  
  def initialize()
    @store = {}
  end
  
  def insert(el)
    @store[el] = true
  end
  
  def include?(el)
    @store.has_key?(el)
  end
  
  def delete(el)
    if @store.include?(el)
      @store.delete(el)
      true
    else
      false
    end
  end
  
  def to_a
    @store.keys
  end
  
  def union(set2)
    set2.store.each do |key, v|
      unless @store.include?(key)
        self.insert(key)
      end
    end
  end
  
  def intersection(set2)
    result = MyHashSet.new
    set2.store.keys.each do |key1|
      if self.include?(key1)
        result.insert(key1)
      end
    end
    result.store
  end
  
end

meow = MyHashSet.new
woof = MyHashSet.new

meow.insert("el")
woof.insert("el")
woof.insert("8==D~~")

puts meow.intersection(woof)