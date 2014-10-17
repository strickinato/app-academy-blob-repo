require './piece.rb'
require './board.rb'
require 'io/console'


module Checkers
  class Game

    attr_reader :current_player

    def initialize
      @board = Board.new
      @current_player = :red
      @colors = [:red, :black]
    end

    def play
      system("clear")
      until over?
        begin
          output_display
          handle_input
          system("clear")
          #get_piece.perform_moves(get_moves)
        rescue SelectionError => e
          system("clear")
          puts e
          retry
        rescue InvalidMoveError => e
          system("clear")
          puts e
          retry
        end
        switch_player
      end
    end


    def output_display
      puts "It's #{@current_player}'s turn"
      @board.display
    end

    def switch_player
      @current_player = (:red ? :black : :red)
    end

    def validate_key
      options = ['w','a','s','d','q',' ',"\r"]
      input = STDIN.getch
      until options.include?(input)
        print 'not a valid key'
        input = STDIN.getch
      end

      input
    end

    def set_piece
      row, col = @board.current_selected_square
      piece = @board.current_piece
        unless piece
          @board.current_piece = @board[row, col]
          assert_valid_piece(@board.current_piece)
        else
          @board.current_piece.perform_moves(@board.current_piece.upcoming_move_sequence)
        end
    end

    def set_route
      row, col = @board.current_selected_square
      if @board.current_piece
        @board.current_piece.upcoming_move_sequence << [row, col]
      end
    end

    def handle_input
      row, col = @board.current_selected_square
      action = validate_key
      case action
      when "q"
        exit
      when "\r"
        set_piece
      when " "
        set_route
      when "w"
        @board.change_selected_square([row - 1, col])
      when "a"
        @board.change_selected_square([row, col - 1])
      when "s"
        @board.change_selected_square([row + 1, col])
      when "d"
        @board.change_selected_square([row, col + 1])
      end
    end

    def assert_valid_piece(piece)
      raise SelectionError.new "That's not a piece!" if piece.nil?
      raise SelectionError.new "It's not your turn!" unless piece.color == @current_player



    end

    def get_moves
      puts "Where to?"
      destinations = []
      loop do
        input = gets.chomp
        break if input == 'q'
        destinations << [input.to_i, gets.chomp.to_i]
        p destinations
      end
      destinations
    end

    def over?
      @colors.any? { |color| @board.all_color(color).empty? }
    end



  end
end

class SelectionError < StandardError

end


if $PROGRAM_NAME == __FILE__
  game = Checkers::Game.new
  game.play
end
