require './db/mysql_connector.rb'
require './models/category.rb'

class Item
  attr_reader :name, :price, :id
  def initialize(param={})
    @id = param[:id]
    @name = param[:name]
    @price = param[:price]
    @categories = param[:categories].nil? ? [] : param[:categories]
  end

  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("select id, name, format(price, 0) as price from items where id = '#{ id }'")
    return nil if raw_data.count == 0
    items = convert_to_array(raw_data)
    return items.count > 1 ? items : items[0]
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
  end

  def delete
    client = create_db_client
    if !@id.nil?
      client.query("delete from order_details where item_id = #{ @id }")
      client.query("delete from item_categories where item_id = #{ @id }")
      client.query("delete from items where id = #{ @id }")
    end
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
        price: row['price'],
        categories: Item.find_categories_by_item_id(row['id'])
      })
      items << item
    end
    items
  end

  def self.find_categories_by_item_id(item_id)
    client = create_db_client
    raw_data = client.query("select items.id as item_id, categories.id as category_id, categories.name as category_name from items left join item_categories on items.id = item_id left join categories on categories.id = category_id where items.id = '#{ item_id }'")
    categories = convert_categories_to_array(raw_data)
    return categories
  end
  
  def self.convert_categories_to_array(raw_data) 
    categories = Array.new
    raw_data.each do |row|
      if row['category_id'].nil? 
        next
      end
      category = Category.new({
        id: row['category_id'],
        name: row['category_name']
      })
      categories << category
    end
    categories
  end

  def categories_string
    string = []
    @categories.each do |category|
      string << category.name
    end
    if string.empty?
      return "No category"
    else 
      string.join(", ")
    end
  end

  def to_s 
    "Item @id = #{ @id } @name=#{ @name }, @price=#{ @price }, @categories=#{ self.categories_string }"
  end
end