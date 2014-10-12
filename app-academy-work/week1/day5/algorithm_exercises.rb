class PolyTreeNode
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent
    @parent
  end
  
  def children
    @children    
  end
  
  def value
    @value
  end
  
  def parent=(parent_node)
    return @parent = nil if parent_node == nil
    @parent.children.delete self if @parent
    @parent = parent_node
    parent_node.children << self    
  end
  
  def add_child(child_node)
    child_node.parent = self    
  end
  
  def remove_child(child_node)
    raise if child_node.parent == nil
    child_node.parent = nil
    
  end
  
  def dfs(value)
    return self if self.value == value
    
    self.children.each do |child|
      child_result = child.dfs(value)
      return child_result unless child_result == nil
    end
    
    nil
  end
  
  def bfs(value)
    search_queue = [self]
    until search_queue.empty?
      current_node = search_queue.shift
      return current_node if current_node.value == value
      current_node.children.each do |child|
        search_queue << child
      end
    end
  end
  
  def trace_back_path(end_pos)
    end_node = self.dfs(end_pos)
    result = []
    until end_node.parent == nil
      result << end_node.value
      end_node = end_node.parent
    end
    result.reverse
  end
end