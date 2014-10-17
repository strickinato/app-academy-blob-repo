
module Checkers

  class InvalidMoveError < StandardError
  end
  class Piece
    DELTAS = [
      [1, 1],
      [1, -1]
    ]

    attr_reader :king, :reader, :color, :pos
    attr_accessor :selected, :upcoming_move_sequence

    def initialize(color, pos, board, king = false)
      @upcoming_move_sequence = []
      @selected = false
      @color = color
      @pos = pos
      @king = king
      @board = board
    end

    def perform_slide(new_pos)
      row_s, col_s = @pos
      row_e, col_e = new_pos

      assert_valid_slide(new_pos)

      @board[row_s, col_s] = nil
      @board[row_e, col_e] = self
      @pos = new_pos
      @king = promote?
    end

    def perform_jump(new_pos)
      row_s, col_s = @pos
      row_e, col_e = new_pos

      assert_valid_jump(new_pos)

      @board.clear_piece(@pos)
      @board.clear_piece(@board.mid_space(@pos, new_pos))
      @board[row_e, col_e] = self
      @pos = new_pos
      @king = promote?

    end

    def perform_moves!(move_arr)
      return false if move_arr.empty?
        #try slide
        if move_arr.count == 1
          move = move_arr.shift
          start_pos = @pos
          end_pos = move
          begin
            #try to slide
            @board[start_pos[0], start_pos[1]].perform_slide(end_pos)
          rescue InvalidMoveError => e
            #try to jump
            @board[start_pos[0], start_pos[1]].perform_jump(end_pos)
          end
        else
          until move_arr.empty?
            move = move_arr.shift
            start_pos = @pos
            end_pos = move
            @board[start_pos[0], start_pos[1]].perform_jump(end_pos)
          end
        end
    end

    def perform_moves(move_sequence)
      try_move_sequence(move_sequence)
      perform_moves!(move_sequence)
      @board.current_piece = nil
    end

    def try_move_sequence(move_sequence)
      row, col = @pos
      dup_board = @board.deep_dup
      dup_board.display
      dup_board[row, col].perform_moves!(move_sequence)
    end

    def promote?
      @king = true if end_row?
    end

    def end_row?
      (@color == :red && @pos[0] == 0) || (@color == :black && @pos[1] == 7)
    end

    def slide_dirs(pos)
      row, col = pos
      slide_dirs = []

      DELTAS.each do |delta|
        slide_dirs << [row + delta[0] * direction, col + delta[1]]
        slide_dirs << [row + delta[0] * -1, col + delta[1]] if king
      end
      slide_dirs
    end

    def jump_dirs(pos)
      row, col = pos
      jump_dirs = []

      DELTAS.each do |delta|
        jump_dirs << [row + delta[0] * 2 * direction, col + delta[1] * 2]
        jump_dirs << [row + delta[0] * -2, col + delta[1] * 2] if king
      end

      jump_dirs
    end

    def display
      displays = {
        red: 'o',
        black: '*'
        }

        displays[color]
    end

    def enemy?(other_piece)
      other_piece.color != @color
    end

    def selected?
      @selected
    end

    def direction
      direction = (@color == :black ? 1 : -1)
    end

    private
    def assert_valid_space(new_pos)
      assert_on_board(new_pos)
      assert_on_game_space(new_pos)
      assert_not_occupied(new_pos)
    end

    def assert_valid_slide(new_pos)
      assert_valid_space(new_pos)

      slides = slide_dirs(@pos)
      raise InvalidMoveError.new "can only slide one space" unless slide_dirs(@pos).include?(new_pos)
    end

    def assert_valid_jump(new_pos)
      assert_valid_space(new_pos)

      jumps = jump_dirs(@pos)
      p jumps
      raise InvalidMoveError.new InvalidMoveError.new "must jump 2 spaces" unless jumps.include?(new_pos)

      mid_pos = @board.mid_space(@pos, new_pos)
      raise InvalidMoveError.new "must jump over a piece" if @board[mid_pos[0], mid_pos[1]].nil?
      raise InvalidMoveError.new "cannot jump own piece" unless enemy?(@board[mid_pos[0], mid_pos[1]])
    end

    def assert_on_board(new_pos)
      row_s, col_s = @pos
      check = (0..7).cover?(row_s) && (0..7).cover?(col_s)
      raise InvalidMoveError.new "cannot move off the board" unless check
    end

    def assert_on_game_space(new_pos)
      row, col = new_pos
      raise InvalidMoveError.new "cannot move on white space" unless @board.game_square?(row, col)
    end

    def assert_not_occupied(new_pos)
      row, col = new_pos
      raise InvalidMoveError.new "cannot move onto another piece" unless @board[row, col].nil?
    end
  end
end
