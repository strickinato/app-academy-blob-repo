require './piece.rb'
require './board.rb'


module Checkers

  b = Board.new


  b[3,1] = Piece.new(:red, [3, 1], b)
  b.clear_piece([6,4])
  b.display
  b[2,2].perform_moves([[3,3]])
  b.display

  # b[2,2].perform_slide([3,4])
  #b[2,0].perform_jump([4,2])

end
