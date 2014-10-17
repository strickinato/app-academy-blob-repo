require 'colorize'

module Checkers
  class Board

    attr_reader :grid
    attr_accessor :current_selected_square, :current_piece

    def initialize(insert = true)
      @current_selected_square = [0, 0]
      @current_piece = nil
      @grid = Array.new(8) { Array.new(8) }
      place_pieces if insert
    end

    def display
      @grid.each_with_index do |row, x|
        row.each_with_index do |piece, y|
          if piece == @current_piece && !piece.nil?
            print " #{piece.display}".on_green
          else
            if [x, y] == @current_selected_square
              print (piece ? " #{piece.display}" : "  ").on_blue
            elsif game_square?(x, y)
              print (piece ? " #{piece.display}" : "  ").on_red
            else
              print (piece ? " #{piece.display}" : "  ").on_white
            end
          end
        end
        print "\n"
      end
    end

    def change_selected_square(new_pos)
      new_pos[0] = new_pos[0] % 8 if new_pos[0] >= 8
      new_pos[0] = 7 if new_pos[0] < 0
      new_pos[1] = new_pos[1] % 8 if new_pos[1] >=8
      new_pos[1] = 7 if new_pos[1] < 0
      @current_selected_square = new_pos
    end


    def [](row, col)
      @grid[row][col]
    end

    def []=(row, col, piece)
      @grid[row][col] = piece
    end

    def clear_piece(pos)
      row, col = pos
      @grid[row][col] = nil
    end

    def game_square?(row, col)
      (row + col).even?
    end

    def mid_space(old_pos, new_pos)
      jumped_diff = [(new_pos[0] - old_pos[0]), (new_pos[0] - old_pos[0])]
      jumped_delta = jumped_diff.map { |pos| pos / 2 }

      [old_pos[0] + jumped_delta[0], old_pos[1] + jumped_delta[1]]
    end

    def deep_dup
      dup_board = Board.new(false)
      all_pieces.each do |piece|
        row, col = piece.pos
        duped_piece = Piece.new(piece.color, piece.pos, dup_board, piece.king)
        dup_board[row, col] = piece
      end

      dup_board
    end

    def all_color(color)
      @grid.flatten.compact.select {|piece| piece.color == color}
    end

    private

    def place_pieces
      @grid.each_with_index do |row, x|
        row.each_with_index do |place, y|
          if game_square?(x, y) && x < 3
            @grid[x][y] = Piece.new(:black, [x, y], self)
          end
          if game_square?(x, y) && x > 4
            @grid[x][y] = Piece.new(:red, [x, y], self)
          end
        end
      end
    end

    def all_pieces
      @grid.flatten.compact
    end


  end
end
