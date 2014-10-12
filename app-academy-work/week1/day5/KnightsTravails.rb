require './algorithm_exercises.rb'


class KnightPathFinder
  attr_reader :move_tree
  
  def initialize(pos)
    @visited_positions = [pos]
    @move_tree = build_move_tree(pos)
  end
  
  
  #Returns array of moves to get to the goal
  def find_path(goal) 
    
  end
  
  # this should call the ::valid_moves class method
  # but then throw out any positions that are already in @visited_positions
  # It should then add the new positions we haven't gotten to 
  # before to @visited_positions
  def new_move_positions(node)
    new_moves = KnightPathFinder.valid_moves(node.value).reject {|move| @visited_positions.include? move}
    new_moves.each {|move| @visited_positions << move}
    new_moves
  end
  
  
  def self.valid_moves(pos)
    x, y = pos
    all = [[x+1,y+2],[x+1,y-2],[x-1,y+2],[x-1,y-2],[x+2,y+1],[x+2,y-1],[x-2,y+1],[x-2,y-1]]
    all.select {|pos| pos[0].between?(0,7) && pos[1].between?(0,7)}
  end
  
  def build_move_tree(root_pos)
    root_node = PolyTreeNode.new(root_pos)
    queue = [root_node]
    until queue.empty?
      current_node = queue.shift
      children = new_move_positions(current_node)
      children.each do |child|
        child_node = PolyTreeNode.new(child)
        child_node.parent = current_node
        queue << child_node
      end
    end
    root_node
  end 
  
  def find_path(end_pos)
    #p @move_tree.class
    @move_tree.trace_back_path(end_pos)
  end
  
end


kpf = KnightPathFinder.new([0,0])
p kpf.find_path([5,5])