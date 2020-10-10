require_relative "item"

class Drink < Item
  attr_reader :caffeine
  alias_method :caffeine?, :caffeine

  def initialize(name, price, tags, size, temperature, is_caffeine)
    super(name, price, tags)
    @size = size
    @temperature = temperature.downcase
    @caffeine = is_caffeine
  end

  def to_s
    result = name_price_to_s()
    result += " size: #{ @size }" if @size
    result += " non-caffeine" if !@caffeine
    result += tags_to_s()
    return result.rstrip
  end

  def match(preference)
    return super(preference) && (preference[:size] == @size) && (preference[:temperature] == @temperature) && (not preference[:caffeine] || preference[:caffeine] == @caffeine)
  end

  def ==(drink)
    return super(drink) && (@caffeine == drink.caffeine?) && (@size == drink.size) && (@temperature == drink.temperature)
  end
end