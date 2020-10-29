class Category
  attr_reader :name, :id
  def initialize(name, id)
    @name = name.nil? ? "No Category" : name
    @id = id
  end

  def to_s 
    "Category @name=#{ @name }"
  end
end