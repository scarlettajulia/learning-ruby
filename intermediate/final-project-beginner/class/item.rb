class Item
  attr_reader :name
  def initialize(name, price, tags)
    @name = name.downcase
    @price = price
    @tags = Array.new
    tags.each{ |tag| @tags.push(tag.downcase) }
  end

  def name_price_to_s
    return @name + " Rp" + @price.to_s
  end

  def tags_to_s
    return " tags: " + @tags.join(", ")
  end

  def to_s 
    puts name_price_to_s()
    puts tags_to_s()
  end

  def match(preference)
    # Return false if not match with item_type, in budget range, or tag not match
    return false if preference[:item_type].downcase != self.class.name.downcase
    return false if @price > preference[:max_budget] || @price < preference[:min_budget]
    preference[:tags].each{ |tag| return true if @tags.include?(tag)}
    # Otherwise return true
    return true
  end

  def ==(item)
    return (@name == item.name) && (@price == item.price) && (@tags == item.tags)
  end

  protected :name_price_to_s, :tags_to_s
end