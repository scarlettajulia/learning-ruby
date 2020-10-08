require_relative "food"
require_relative "drink"

class Menu
  def initialize(n)
    @menus = Array.new
    @num_of_item_menu = n
    puts "Created #{@num_of_item_menu} menu" if @num_of_item_menu
  end

  def add_item(item)
    if !@num_of_item_menu || @menus.length < @num_of_item_menu
      item.add_item_to(@menus)
    else
      puts "Menu is full, can't add #{item.name}"
    end
  end

  def add_food(name, price, tags, is_vegan)
    new_food = Food.new(name, price, tags, is_vegan)
    add_item(new_food)
  end

  def add_drink(name, price, tags, size, temperature, is_caffeine)
    new_drink = Drink.new(name, price, tags, size, temperature, is_caffeine)
    add_item(new_drink)
  end

  def get_recommendation(preferences)
    recommendations = Array.new
    @menus.each{ |menu| recommendations.push(menu.name.capitalize) if menu.match(preferences)}
    return recommendations
  end

  def list_menu()
    puts !@menus.empty? ? @menus : "No item in menu"
  end
end