class Preference
  def initialize
    @preference = Hash.new
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

  private :get_item_type, :get_flavour_preference, :get_budget_preference, :get_food_preference, :get_drink_preference, :get_originality_preference 
end