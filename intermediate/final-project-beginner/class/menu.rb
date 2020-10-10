require_relative "food"
require_relative "drink"

class Menu
  attr_reader :menus
  def initialize(n)
    @menus = Array.new
    @num_of_item_menu = n
    puts "Created #{@num_of_item_menu} menu" if @num_of_item_menu
  end

  def add_item(item)
    if !@num_of_item_menu || @menus.length < @num_of_item_menu
      if !@menus.include?(item)
        @menus.push(item)
        puts "#{ item.name } added"
      else
        puts "#{ item.name } already exist in menu"
      end
    else
      puts "Menu is full, can't add #{item.name}"
    end
  end

  def get_recommendation(preferences)
    recommendations = Array.new
    @menus.each{ |menu| recommendations.push(menu.name.capitalize) if menu.match(preferences)}
    return recommendations
  end

end