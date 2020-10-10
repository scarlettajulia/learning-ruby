require_relative "item"

class Food < Item
  attr_reader :vegan
  alias_method :vegan?, :vegan

  def initialize(name, price, tags, is_vegan)
    super(name, price, tags)
    @vegan = is_vegan
  end

  def to_s
    result = name_price_to_s()
    result += " non-vegan" if !@vegan
    result += tags_to_s()
    return result.rstrip
  end

  def match(preference)
    return super(preference) && (not preference[:vegan] || preference[:vegan] == @vegan)
  end

  def ==(food)
    return super(food) && (@vegan == food.vegan?)
  end
end