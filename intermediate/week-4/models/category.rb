require './db/mysql_connector.rb'
require './models/item.rb'

class Category
  attr_reader :name, :id, :items
  def initialize(param={})
    @id = param[:id]
    @name = param[:name].nil? ? "No category" : param[:name]
    @items = param[:items].nil? ? [] : param[:items]
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name from categories where id = '#{ id }'")
    return nil if raw_data.count == 0
    categories = convert_to_array(raw_data)
    return categories.count > 1 ? categories : categories[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query ("select id, name from categories")
    return [] if raw_data.count == 0
    categories = convert_to_array(raw_data)
    return categories.count > 1 ? categories : categories[0]
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
  end

  def delete
    return false unless valid?
    client = create_db_client
    if !@id.nil?
      client.query("delete from item_categories where category_id = #{ @id }")
      client.query("delete from categories where id = #{ @id }")
    end
  end

  def valid?
    return false if @name.nil?
    true
  end

  def self.find_items_by_category_id(category_id)
    client = create_db_client
    raw_data = client.query("select items.id as item_id, items.name as item_name, format(items.price, 0) as item_price from categories left join item_categories on categories.id = category_id left join items on items.id = item_id where category_id = '#{ category_id }'")
    convert_items_to_array(raw_data)
  end
  
  def self.convert_items_to_array(raw_data) 
    items = Array.new
    raw_data.each do |row|
      if row['item_id'].nil? 
        next
      end
      item = Item.new({
        id: row['item_id'],
        name: row['item_name'],
        price: row['item_price']
      })
      items << item
    end
    items
  end

  def self.convert_to_array(raw_data)
    categories = Array.new
    raw_data.each do |row|
      category = Category.new({
        id: row["id"],
        name: row["name"],
        items: Category.find_items_by_category_id(row['id'])
      })
      categories << category
    end
    categories
  end

  def to_s 
    "#{ @name }"
  end

  def items_string
    string = []
    @items.each do |item|
      string << item.name
    end
    string.join(", ")
  end

  def to_s 
    "Category @id = #{ @id } @name=#{ @name }, @items=#{ self.items_string }"
  end
end