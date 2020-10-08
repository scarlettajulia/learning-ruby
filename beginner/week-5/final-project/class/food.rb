require_relative "item"

class Food < Item
  def initialize(name, price, tags, is_vegan)
    super(name, price, tags)
    @is_vegan = is_vegan
  end

  def to_s
    result = name_price_to_s()
    result += " non-vegan" if !@is_vegan
    result += tags_to_s()
    return result.rstrip
  end

  def match(preference)
    return super(preference) && (preference[:vegan] == @is_vegan)
  end

  def ==(food)
    return super(food) && (@is_vegan == food.is_vegan)
  end
end