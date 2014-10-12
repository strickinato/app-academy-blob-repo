def caesar(str, n)
  chars = str.split("")
  alph = "a".."z".to_a
  return_arr = []
  chars.each do |letter|
    if letter.ord + n > 122
      next_char = ((letter.ord+n) - 26 ).chr
    else
      next_char = (letter.ord + n).chr
    end
    return_arr << next_char
  end
  return_arr.join("")
end

puts caesar("zello", 3)