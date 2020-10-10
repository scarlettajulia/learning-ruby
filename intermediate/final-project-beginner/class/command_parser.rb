require_relative "recommendation_system"

class CommandParser
  attr_reader :dead
  alias_method :dead?, :dead

  def initialize
    @dead = false
    @recommendation_system = RecommendationSystem.new
  end

  def run()
    while !@dead
      print "> "
      read_command()
    end
  end

  def read_command()
    available_tags = ["sweet", "sour", "bitter", "spicy", "salty", "umami", "healthy", "junk_food", "italy", "japan", "indonesia", "china"]   
    command = gets.chomp
    command, *variables = command.split(" ")
    case command
    when "create_menu"
      @recommendation_system.create_menu(variables[0].to_i) if variables[0].to_i > 0
      puts "Create menu command failed. Number of entry should be more than 0" if !(variables[0].to_i > 0) 
    when "add_food"
      # Assumption : user input "add_food <name> <price> <non-vegan/vegan> <tag_1> <tag_2> .. <tag_n>"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      @recommendation_system.add_food(variables[0], variables[1].to_i, tags, !variables.include?("non-vegan"))
    when "add_drink"
      # Assumption : user input "add_drink <name> <price> <S/M/L> <hot/cold> <non-caffeine/caffeine> <tag_1> <tag_2> .. <tag_n>"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      @recommendation_system.add_drink(variables[0], variables[1].to_i, tags, variables[2], variables[3], !variables.include?("non-caffeine"))
    when "list_menu"
      @recommendation_system.list_menu()
    when "give_recommendations"
      @recommendation_system.give_recommendations()
    when "exit"
      puts "Goodbye!"
      @dead = true
    else 
      puts "No command recognized. (created_menu, add_food, add_drink, list_menu, give_recommendations, exit)"
    end
  end
end