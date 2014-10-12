def our_loop
  i = 250
  i += 1 until i % 7 == 0
  i
end

def solution_our_loop
  i = 0

  i += 1 until (i > 250) && (i % 7 == 0)

  i
end

def factors(n)
  [].tap do |factors|
    (1..n).each do |i|
      factors << i if n % i == 0
    end
  end
end

def solution_factors(num)
  (1..num).select { |i| num % i == 0}
end

def bubble_sort(arr)

  flag = true
  while flag
    flag=false
    (0..arr.length-2).each do |i|
      if arr[i] > arr[i+1]
        arr[i],arr[i+1] = arr[i+1],arr[i]
        flag = true
      end
    end
  end
  arr
end

class Array
  def solution_bubble_sort
      sorted = false
      until sorted
        sorted = true

        self.each_index do |index|
          next if (index + 1) == self.count

          if self[index] > self[index + 1]
            self[index], self[index + 1] = self[index + 1], self[index]
            sorted = false
          end
        end
      end

    self
  end
end




def substrings(string)
  lines = File.read('dictionary.txt').split("\n")
  lines = File.readlines('dictionary.txt').map(&:chomp)
  output_arr = []
  string.split('').each_index do |i|
    (i..string.length - 1).each do |j|
      output_arr << string[i..j] if lines.include?(string[i..j])
    end
  end

  output_arr
end

def solution_substrings(word, dictionary_filename)
  dictionary_words = File.readlines(dictionary_filename).map(&:chomp)

  substrings(word.downcase).select do |substr|
    dictionary_words.include?(substr)
  end.uniq.sort
end

p solution_substrings("antidistastablishmentariansim", 'dictionary.txt')
