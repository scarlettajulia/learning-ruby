require_relative "class/command_parser.rb"

# Helper function
def get_input(message)
  print message + " "
  result = gets.chomp
  return result
end

def print_with_line(message)
  puts message
  puts "=" * message.length 
end

command_parser = CommandParser.new
command_parser.run()