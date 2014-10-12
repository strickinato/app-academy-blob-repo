class Game
  attr_reader :guesser, :secret_word, :checker
  attr_accessor :incorrect_guesses, :correct_guesses, :display_array
 
   def initialize(guesser, checker)
     @guesser = guesser
     @checker = checker
     @correct_guesses = []
     @incorrect_guesses = []
     @secret_word = checker.pick_secret_word
     @display_array = Array.new(secret_word.length, '_')
   end
 
   def play
     guesser.receive_secret_length(secret_word.length)
     until won? || lost?
       puts display
       puts "incorrect guesses: #{incorrect_guesses}"
       current_guess = guesser.guess
       handle_guess(current_guess)
       
     end
     won? ? (puts "Good Job, #{guesser.name}") : (puts "The secret word will remain hidden forever! Nice #{checker.name}!")
   end

   def handle_guess(current_guess)
     in_word = checker.handle_guess_response(current_guess)
     in_word ? 
            handle_correct(current_guess) : handle_incorrect(current_guess) 
   end

   def handle_correct(ltr)
     correct_guesses << ltr
     guesser.send_response(true, ltr)
   end
   
   def handle_incorrect(ltr)
     incorrect_guesses << ltr
     guesser.send_response(false, ltr)
   end

   def lost?
     incorrect_guesses.length >= 20 
   end
   
   def won?
     !display.include?('_')
   end
   
   
 
   def display
     display_array = []
     secret_word.each_char do |chr|
       correct_guesses.include?(chr) ? 
         display_array << chr : display_array << '_'
     end
     
     return display_array.join('')
   end
 
  
end



class Player
  attr_reader :name
  attr_accessor :secret_word, :secret_word_length
  
  def initialize(name)
    @name = name
    @secret_word = ''
    @secret_word_length = 0
  end
  
  def pick_secret_word
    
  end
  
  def receive_secret_length(len)
    p len
    self.secret_word_length = len
  end
  
  def guess
  end
  
  def check_guess?(ltr)
    
  end
  
  def handle_guess_response(ltr)
  end

  def send_response(resp, ltr)
    resp
  end

end

class HumanPlayer < Player
  def pick_secret_word
    puts "#{ name }: Pick a word."
    secret_word = gets.chomp
  end
  
  def guess
    
    puts "what's your guess, #{ name }?"
    letter = gets.chomp
    until letter.downcase.match(/[a-z]/) && letter.length == 1
      puts "A letter - numnutz, guess again."
      letter = gets.chomp
    end
    
    letter
  end
  
  
  
  def handle_guess_response(ltr)
    puts "#{ name }, Is \'#{ltr}\' in the word? (y/n)"
    response = gets.chomp
    response == 'y'
  end
  
  
  
end

class ComputerPlayer < Player
  attr_accessor :letter_hash, :word_bank, :dict_file
  
  def initialize(name)
    super(name)
     @letter_hash = Hash.new(0)
     @dict_file = get_dict_file
     @word_bank = dict_file
  end
  
  def update_letter_hash
    self.letter_hash = Hash.new(0)
    word_bank.each do |word|
      word.each_char do |chr|
        letter_hash[chr] += 1
      end
    end
    p letter_hash
  end
  
  def update_word_bank_length
    word_bank.select! { |x| x.length == secret_word_length}
  end
  
  def update_word_bank_letters(resp, ltr)
    if resp
      word_bank.select! { |x| x.include?(ltr) }
    else
      word_bank.select! { |x| !x.include?(ltr) }
    end
  end
  
  def get_dict_file
    File.readlines('dictionary.txt').map(&:chomp)
  end
  
  def pick_secret_word
    self.secret_word = word_bank.sample
  end
  
  def handle_guess_response(ltr)
    secret_word.include?(ltr)
  end
  
  def guess
    update_word_bank_length
    update_letter_hash
    letter_hash.max_by { |k,v| v }.first
  end
  
  def send_response(resp, ltr)
    update_word_bank_letters(resp, ltr)
  end
  
  
end

guesser = HumanPlayer.new('aaron')
checker = ComputerPlayer.new('smartBot')
game = Game.new(checker, guesser)
game.play