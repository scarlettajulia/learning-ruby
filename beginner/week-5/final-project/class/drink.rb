require_relative "item"

class Drink < Item
  def initialize(name, price, tags, size, temperature, is_caffeine)
    super(name, price, tags)
    @size = size
    @temperature = temperature.downcase
    @is_caffeine = is_caffeine
  end

  def to_s
    result = name_price_to_s()
    result += " size: #{ @size }" if @size
    result += " non-caffeine" if !@is_caffeine
    result += tags_to_s()
    return result.rstrip
  end

  def match(preference)
    return super(preference) && (preference[:size] == @size) && (preference[:temperature] == @temperature) && (preference[:caffeine] == @is_caffeine)
  end

  def ==(drink)
    return super(drink) && (@is_caffeine == drink.is_caffeine) && (@size == drink.size) && (@temperature == drink.temperature)
  end
end