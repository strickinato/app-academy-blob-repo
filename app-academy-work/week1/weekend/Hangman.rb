require 'set'

class Hangman
  $GUESSES_ALLOWED = 10

  attr_accessor :correct_indexes, :board
  attr_reader :wrong_guesses

  def initialize
    @correct_indexes = []
    @wrong_guesses = 0
    @board = []
  end


  def play(guesser, checker)
    @secret_word = checker.get_secret_word
    guesser.receive_secret_length(@secret_word.length)
    make_space

    until over?
      update_board

      show_past_guesses(guesser)
      show_remaining_guesses
      print_board

      player_guesses(guesser, checker)
      guesser.handle_guess_response(@correct_indexes, update_board)

    end

    update_board
    print_board
    winning_message(guesser, checker)
  end

  def show_remaining_guesses
    puts "Remaining Guesses: #{$GUESSES_ALLOWED - @wrong_guesses}"
  end

  def show_past_guesses(guesser)
    puts "Previous Guesses:#{guesser.guesses}"
  end

  def winning_message(guesser, checker)
    if @wrong_guesses == 10
      puts "Nice word, #{checker.name}, the secret is safe."
    else
      puts "Great guessing!! #{guesser.name} wins!!"
    end
  end

  def make_space
    100.times { puts }
  end

  def player_guesses(guesser, checker)
    old_guesses = @correct_indexes
    current_guess = guesser.guess

    puts "#{guesser.name} guessed #{current_guess.upcase}"
    @correct_indexes += checker.check_guess(current_guess)
    @wrong_guesses += 1 if @correct_indexes == old_guesses
    @correct_indexes.uniq!
  end

  def update_board
    (0...@secret_word.length).each do |i|
      if @correct_indexes.include?(i)
        @board[i] = @secret_word[i].upcase
      else
        @board[i] = '_'
      end
    end
    @board
  end

  def print_board
    print @board.join(' ')
    puts
    (0...@secret_word.length).each {|i| print "#{i} " }
    puts
  end

  def over?
    @correct_indexes.count == @secret_word.length || wrong_guesses == 10
  end

end



class HumanPlayer
  attr_reader :name, :guesses

  def initialize(name)
    @name = name
    @secret_word = ''
    @guesses = []
  end

  def get_secret_word
    puts "#{name.capitalize}, please enter a secret word:"
    @secret_word = gets.chomp
    until @secret_word.match(/^[a-z]*$/i)
      puts "Enter a *word* with no spaces please:"
      @secret_word = gets.chomp
    end

    @secret_word
  end

  def guess
    puts "#{name.capitalize}, what letter do you guess?"
    guess = gets.chomp
    until guess.match(/^[a-z]$/i)
      puts "Please enter a letter:"
      guess = gets.chomp
    end
    @guesses << guess
    guess
  end

  def check_guess(guess)
    correct_indexes = []

    puts "#{name.capitalize}, is this letter in your secret word? (y,n)"
    responses = ['y','yes', 'n', 'no']
    response = gets.chomp

    until responses.include?(response.downcase)
      puts 'Please type yes or no'
      response = gets.chomp
    end

    if responses.index(response) <= 1
      puts 'What indexes are the guess at?'
      index = gets.chomp
      until index == 'q'
        correct_indexes << index.to_i
        index = gets.chomp
      end
    end

    correct_indexes
  end

  def handle_guess_response(correct_indexes, board)

  end


  def receive_secret_length(length)
    @secret_word_length = length
  end

end


class ComputerPlayer
  attr_reader :word_bank, :name, :guesses
  attr_accessor :secret_word

  def initialize(name)
    @name = name
    @word_bank = File.readlines('dictionary.txt').map!(&:chomp)
    @secret_word = ''
    @guesses = []
  end

  def get_secret_word
    @secret_word = @word_bank.sample
  end

  def receive_secret_length(length)
    @secret_word_length = length
  end

  def guess
    best_guesses = Hash.new { |k,v| k[v] = 0 }

    @word_bank.each do |word|
      word.split('').uniq.each do |chr|
        best_guesses[chr] += 1 unless @guesses.include?(chr)
      end
    end
    p best_guesses
    new_guess = best_guesses.max_by { |k, v| v }.first
    @guesses << new_guess

    new_guess
  end

  def handle_guess_response(correct_indexes, board)
    @word_bank.select! {|word| word.length == @secret_word_length}
    @word_bank.select! do |word|
      correct_indexes.all? do |index|
        word[index] == board[index].downcase unless word[index].nil?
      end
    end

    nil
  end

  def check_guess(guess)
    new_correct_indexes = []
    @secret_word.split('').each_with_index do |chr, index|
      new_correct_indexes << index if chr == guess
    end
    new_correct_indexes
  end

end


if $PROGRAM_NAME == __FILE__
  game = Hangman.new
  guesser = ComputerPlayer.new("Dick")
  checker = ComputerPlayer.new("Aaron")

  game.play(guesser, checker)


end
