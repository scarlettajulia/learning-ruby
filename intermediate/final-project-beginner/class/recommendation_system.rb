require_relative "food"
require_relative "drink"
require_relative "menu"

class RecommendationSystem
  def initialize
    @menu = Menu.new(nil)
    @preference = Hash.new
  end

  def create_menu(n)
    @menu = Menu.new(n)
  end

  def add_food(name, price, tags, is_vegan)
    new_food = Food.new(name, price, tags, is_vegan)
    @menu.add_item(new_food)
  end

  def add_drink(name, price, tags, size, temperature, is_caffeine)
    new_drink = Drink.new(name, price, tags, size, temperature, is_caffeine)
    @menu.add_item(new_drink)
  end

  def list_menu()
    puts !@menu.menus.empty? ? @menu.menus : "No item in menu"
  end

  def check_any_input(input)
    return input == "any" ? nil : input
  end

  def get_item_type()
    return get_input("Do you want to drink/eat?").downcase == "eat" ? "food" : "drink"
  end
  
  def get_flavour_preference()
    return check_any_input(get_input("What flavour do you prefer (sweet, salty, sour, bitter, spicy, umami)?").downcase)
  end

  def get_budget_preference()
    budget = get_input("How many budgets do you have per person (range)?").split("-")
    min_budget = budget[0].to_i < budget[1].to_i ? budget[0].to_i : budget[1].to_i
    max_budget = budget[0].to_i > budget[1].to_i ? budget[0].to_i : budget[1].to_i
    return min_budget, max_budget
  end

  def get_food_preference()
    vegan = get_input("Are you vegan (no/yes)?").downcase == "yes" ? true : false
    food_type = check_any_input(get_input("Do you prefer healthy food or junk food (healthy/junk_food)?").downcase)
    return vegan, food_type
  end

  def get_drink_preference()
    size = check_any_input(get_input("Which size do you want (S/M/L)?").upcase)
    temperature = check_any_input(get_input("Which temperature do you want (hot/cold)?").downcase)
    caffeine = get_input("Do you want caffeine (yes/no)?").downcase == "no" ? false : true
    return size, temperature, caffeine
  end

  def get_originality_preference()
    originality = check_any_input(get_input("Originality (italy, japan, indonesia, china)?").downcase) 
    return originality
  end

  def ask_preferences
    @preference[:item_type] = get_item_type()
    @preference[:tags] = Array.new
    @preference[:tags].push(get_flavour_preference())
    @preference[:min_budget], @preference[:max_budget] = get_budget_preference() 
    case @preference[:item_type]
    when "food"
      @preference[:vegan], food_type = get_food_preference() 
      @preference[:tags].push(food_type)
    when "drink"
      @preference[:size], @preference[:temperature], @preference[:caffeine] = get_drink_preference()
    end
    originality = get_originality_preference()
    @preference[:tags].push(originality) if originality
    return @preference
  end

  def give_recommendations 
    # Create preference_assistant to handle the preference gathering
    @preference = Hash.new
    preferences = ask_preferences()
    # Create the recommendations
    recommendations = @menu.get_recommendation(preferences)
    # Print recommendation
    puts "Recommendations for you:"
    puts recommendations.empty? ? "No recommendation suits your taste :(" : recommendations
  end
end