class Item
  attr_reader :name, :price, :id, :category
  def initialize(name, price, id, category=nil)
    @name = name
    @price = price
    @id = id
    @category = category
  end

  def to_s 
    "Item @name=#{ @name }, @price=#{ @price }, @category=#{ @category }"
  end
end