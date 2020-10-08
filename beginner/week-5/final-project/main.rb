require_relative "class/recommendation_system.rb"

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

recommendation_system = RecommendationSystem.new
while recommendation_system.continue?
  print "> "
  recommendation_system.read_command()
end