require './db/mysql_connector.rb'
require './models/item.rb'
require './models/item_category.rb'

class Category
  attr_reader :name, :id, :items
  def initialize(param={})
    @id = param[:id].nil? ? nil : param[:id].to_i
    @name = param[:name]
    @items = []
  end

  def items
    item_categories = ItemCategory.find_by_category_id(@id)
    @items = Item.get_items(item_categories)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name from categories where id = '#{ id }'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query ("select id, name from categories")
    client.close
    convert_to_array(raw_data)
  end

  def save 
    return false unless valid?
    client = create_db_client
    if @id.nil?
      client.query("insert into categories (name) values ('#{ @name }')")
      @id = client.last_id
    else
      client.query("update categories set name = '#{ @name }' where id = '#{ @id }'")
    end
    client.close
    true
  end

  def delete
    return false unless valid?
    client = create_db_client
    if !@id.nil?
      client.query("delete from item_categories where category_id = #{ @id }")
      client.query("delete from categories where id = #{ @id }")
    end
    client.close
    true
  end

  def valid?
    return false if @name.nil?
    true
  end

  def self.get_categories(item_categories)
    categories = Array.new
    item_categories.each do |item_category|
      category = Category.find_by_id(item_category.category_id)[0]
      categories << category
    end
    categories
  end

  def self.convert_to_array(raw_data)
    categories = Array.new
    raw_data.each do |row|
      category = Category.new({
        id: row['id'],
        name: row['name']
      })
      categories << category
    end
    categories.sort_by(&:id)
  end

  def items_to_s
    items
    return "No category" if @items.empty?
    return @items[0].name if @items.length == 1
    item_names = []
    @items.each do |item|
      item_names << item.name
    end
    items_except_last = item_names.slice(0, item_names.length - 1).join(", ")
    "#{ items_except_last } and #{ item_names[-1] }"
  end

  def ==(category)
    return self.id == category.id && self.name == category.name
  end

  def to_s 
    "Category @id = #{ @id } @name=#{ @name }, @items=#{ self.items_to_s }"
  end
end