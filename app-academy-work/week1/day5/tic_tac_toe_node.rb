require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def self.opposite_mark(mark)
    mark == :x ? :o : :x
  end
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return @board.winner == TicTacToeNode.opposite_mark(evaluator)
    end
    
    loser = Proc.new {|child| child.losing_node?(evaluator)}
    if evaluator == @next_mover_mark
      self.children.all?(&loser)
    else
      self.children.any?(&loser)
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    end
    
    winner = Proc.new { |child| child.winning_node?(evaluator)}
    if evaluator == @next_mover_mark
      self.children.any?(&winner)
    else
      self.children.all?(&winner)
    end    
  end

  def children
    possible_moves = []
    
    (0..2).each do |row|
      (0..2).each do |col|
        current_pos = [row, col]
        next_board = (@board.dup)
        
        if next_board.empty?(current_pos)
          next_board[current_pos] = @next_mover_mark
          next_marker = TicTacToeNode.opposite_mark(@next_mover_mark)
          possible_moves << TicTacToeNode.new(
            next_board, 
            next_marker, 
            current_pos
          )
        end
      end
    end
    
    possible_moves
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  node = TicTacToeNode.new(b, :x)
  p node.children[1].losing_node?(:x)
end
