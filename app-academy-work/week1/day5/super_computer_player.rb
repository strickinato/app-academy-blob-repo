require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    
    winner = node.children.find { |child| child.winning_node? mark }
    not_loser = node.children.find { |child| !child.losing_node? mark }
    
    best_move_node = winner || not_loser
    
    return best_move_node.prev_move_pos unless best_move_node.nil?
    raise "impossible!"

  end
end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
