require_relative "food"
require_relative "drink"
require_relative "menu"
require_relative "preference"

class RecommendationSystem
  def initialize
    @kill_instance = false
    @menus = Menu.new(nil)
  end

  def read_command()
    available_tags = ["sweet", "sour", "bitter", "spicy", "salty", "umami", "healthy", "junk_food", "italy", "japan", "indonesia", "china"]   
    command = gets.chomp
    variables = command.split(" ")
    
    case variables[0]
    when "create_menu"
      @menus = Menu.new(variables[1].to_i) if variables[1].to_i > 0
      puts "Create menu command failed. Number of entry should be more than 0" if !(variables[1].to_i > 0) 
    
    when "add_food"
      # Assumption : user input "add_food <name> <price> <non-vegan/vegan> <tag_1> <tag_2> .. <tag_n>"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      @menus.add_food(variables[1], variables[2].to_i, tags, !command.include?("non-vegan"))
    
    when "add_drink"
      # Assumption : user input "add_drink <name> <price> <S/M/L> <hot/cold> <non-caffeine/caffeine> <tag_1> <tag_2> .. <tag_n>"
      tags = Array.new
      variables.each{ |var| tags.push(var) if available_tags.include?(var) }
      @menus.add_drink(variables[1], variables[2].to_i, tags, variables[3], variables[4], !command.include?("non-caffeine"))
    
    when "list_menu"
      @menus.list_menu()
    
    when "give_recommendations"
      give_recommendations()
    
    when "exit"
      puts "Goodbye!"
      @kill_instance = true
    
    else 
      puts "No command recognized. (created_menu, add_food, add_drink, list_menu, give_recommendations, exit)"
    end
  end

  def give_recommendations 
    # Create preference_assistant to handle the preference gathering
    preference_assistant = Preference.new
    preferences = preference_assistant.ask_preferences()
    
    # Create the recommendations
    recommendations = @menus.get_recommendation(preferences)
    
    puts "Recommendations for you:"
    puts recommendations.empty? ? "No recommendation suits your taste :(" : recommendations
  end

  def continue?
    return !@kill_instance
  end

  private :give_recommendations
end