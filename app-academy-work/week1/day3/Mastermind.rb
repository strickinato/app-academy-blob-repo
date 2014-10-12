class Code
  attr_reader :sequence
  
  def initialize(pegs_array)
    @sequence = pegs_array
  end
  
  def self.random
    colors = [:r, :g, :b, :y, :o, :p]
    Code.new(colors.sample(4))
  end
  
  def self.parse(input)
    Code.new(input.downcase.split('').map(&:to_sym))
  end
  
  def exact_matches(code_object2)
    count = 0
    code_object2.sequence.each_with_index do |x, i|
      count += 1 if self.sequence[i] == x
    end
    count
  end
  
  def near_matches(code_object2)
    matches = Hash.new{|h,k| h[k] = [0, 0, 0]}
    self.sequence.each_with_index do |color, index|
      matches[color][0] += 1
    end
    code_object2.sequence.each_with_index do |color, index|
      matches[color][1] += 1
    end
    self.sequence.each_with_index do |color, index|
      matches[color][2] += 1 if code_object2.sequence[index] == color
    end
    count = 0
    
    matches.each_value do |v|
      count += (v[0..1].min - v[2])      
    end

    count
  end  
end

class Game
  attr_reader :secret_code
  attr_accessor :user_code, :user_code_history, :turns
  
  def initialize
    @secret_code = Code.random
    @user_code_history = []
    @user_code = nil
    @turns = 0
  end
  
  def won?
    user_code && secret_code.exact_matches(user_code) == 4
  end
  
  def lost?
     turns == 10
  end
  
  def play
    until lost? || won?
      self.user_code = user_prompt
      user_code_history << user_code
      print_response
      self.turns += 1
    end
    won? ? (puts "Nice job friend! You won in #{turns} turns") : (puts "Loser!") 
  end
  
  
  
  def print_response
    user_code_history.each_with_index do |code, idx|
      puts "Turn #{idx + 1}: #{code.sequence} has #{code.exact_matches(secret_code)} exact matches and #{code.near_matches(secret_code)} near matches"
    end
  end
  
  def user_prompt
    
    loop do
      puts "Make your guess (R G B Y O P)"
      user_input = gets.chomp
      if user_input.match(/[RGBYOP]/i) && user_input.length == 4
        return Code.parse(user_input)
      else
        puts "Do it again!"
      end
    end
  end
end

game = Game.new
game.play