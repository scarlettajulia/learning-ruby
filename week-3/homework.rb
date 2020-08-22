def get_input(message)
  print message + " "
  result = gets.chomp
  return result
end

def print_with_line(message)
  puts message
  puts "=" * message.length 
end

def vowel?(char)
  vowel = ["a", "i", "u", "e", "o"]
  return vowel.include?(char)
end

def swap_char(string)
  # Assumption always lower case, won't be empty, no special char
  alphabets = ("a".."z").to_a
             
  # Move 9 forward for consonant, 5 backword for vowel
  result = ""
  for i in 0...string.length 
    idx = alphabets.index(string[i])
    idx += vowel?(string[i]) ? -5 : 9
    result += alphabets[idx % alphabets.length]
  end
  return result
end

input_string = get_input("Provided string =")
puts "Result = #{swap_char(input_string)}"