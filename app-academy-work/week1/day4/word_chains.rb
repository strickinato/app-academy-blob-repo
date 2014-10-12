require 'set'

class WordChainer

  attr_reader :dictionary
  #attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = generate_dictionary(dictionary_file_name)
    @current_words = []
    @all_seen_words = Hash.new(nil)

  end

  def run(source, target)
    @current_words << source
    @all_seen_words[source] = nil


    until @current_words.empty?
      explore_current_words(source)
    end

    puts build_path(target)
end

  def explore_current_words(source)
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          next if @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end

        @current_words = new_current_words
      end

  end



  private
  def generate_dictionary(dictionary_file_name)
    all_words_array = File.readlines(dictionary_file_name).map(&:chomp)

    all_words_set = Set.new []

    all_words_array.each do |word|
      all_words_set.add(word)
    end

    all_words_set
  end


  def build_path(target)
    path = [target]
    loop do
      path << @all_seen_words[target]
      target = @all_seen_words[target]
      break if @all_seen_words[target].nil?
    end

    path.reverse
  end

  def adjacent_words(word)
    word_chars = word.split('')
    adjacent_words_set = Set.new []

    word_chars.each_with_index do |chr, i|
      ('a'..'z').to_a.each do |ltr|
        word_chars[i] = ltr
        alt_word = word_chars.join('')
        adjacent_words_set.add(alt_word) if dictionary.include?(alt_word)
        word_chars[i] = chr
      end
    end

    adjacent_words_set
  end

end

aaron = WordChainer.new('dictionary.txt')
aaron.run('rain', 'list')
