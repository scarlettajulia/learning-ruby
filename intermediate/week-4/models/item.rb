require './db/mysql_connector.rb'
require './models/category.rb'
require './models/item_category.rb'

class Item
  attr_reader :name, :price, :id
  def initialize(param={})
    @id = param[:id]
    @name = param[:name]
    @price = param[:price].nil? ? param[:price] : param[:price].tr(',.', '')
    @categories = []
  end

  def categories 
    item_categories = ItemCategory.find_by_item_id(@id)
    @categories = Category.get_categories(item_categories)
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name, format(price, 0) as price from items where id = '#{ id }'")
    client.close
    convert_to_array(raw_data)
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query ("select id, name, format(price, 0) as price from items")
    convert_to_array(raw_data)
  end

  def save 
    return false unless valid?
    @price.to_s.gsub!(',', '')
    client = create_db_client
    if @id.nil?
      client.query("insert into items (name, price) values ('#{ @name }', '#{ @price }')")
      @id = client.last_id
    else
      client.query("update items set name = '#{ @name }', price = '#{ @price }' where id = '#{ @id }'")
    end
    client.close
    true
  end

  def delete
    client = create_db_client
    if !@id.nil?
      client.query("delete from order_details where item_id = #{ @id }")
      client.query("delete from item_categories where item_id = #{ @id }")
      client.query("delete from items where id = #{ @id }")
    end
    client.close
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    true
  end

  def self.convert_to_array(raw_data)
    items = Array.new
    raw_data.each do |row|
      item = Item.new({
        id: row['id'],
        name: row['name'],
        price: row['price']
      })
      items << item
    end
    items
  end

  def self.get_items(item_categories)
    items = Array.new
    item_categories.each do |item_category|
      item = Item.find_by_id(item_category.item_id)[0]
      items << item
    end
    items
  end

  def categories_to_s
    categories
    return "No category" if @categories.empty?
    return @categories[0].name if @categories.length == 1
    category_names = []
    @categories.each do |category|
      category_names << category.name
    end
    categories_except_last = category_names.slice(0, category_names.length - 1).join(", ")
    "#{ categories_except_last } and #{ category_names[-1] }"
  end

  def to_s 
    "Item @id = #{ @id } @name=#{ @name }, @price=#{ @price }, @categories=#{ self.categories_to_s }"
  end
end