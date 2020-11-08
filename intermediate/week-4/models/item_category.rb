require './db/mysql_connector.rb'
require './models/item.rb'
require './models/category.rb'

class ItemCategory
  attr_reader :item_id, :category_id
  def initialize(param)
    @item_id = param[:item_id]
    @category_id = param[:category_id]
  end
  
  def save 
    return false unless valid?
    client = create_db_client
    item_category = ItemCategory.find_row(@item_id, @category_id)
    if item_category.empty?
      client.query("insert into item_categories (item_id, category_id) values ('#{ @item_id }', '#{ @category_id }')")
      true
    end
    false
  end

  def delete
    return false unless valid?
    client = create_db_client
    client.query("delete from item_categories where item_id = #{ @item_id } and category_id = #{ @category_id }")
  end

  def valid?
    return false if @item_id.nil?
    return false if @category_id.nil?
    true
  end
  
  def self.find_row(item_id, category_id)
    client = create_db_client
    raw_data = client.query("select item_id, category_id from item_categories where item_id = '#{ item_id }' and category_id = '#{ category_id }'")
    item_categories = convert_to_array(raw_data)
  end

  def self.find_by_item_id(item_id)
    client = create_db_client
    raw_data = client.query("select item_id, category_id from item_categories where item_id = '#{ item_id }'")
    item_categories = convert_to_array(raw_data)
  end

  def self.find_by_category_id(category_id)
    client = create_db_client
    raw_data = client.query("select item_id, category_id from item_categories where category_id = '#{ category_id }'")
    item_categories = convert_to_array(raw_data)
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query ("select items.id as item_id, category_id from items left join item_categories on items.id = item_categories.item_id")
    convert_to_array(raw_data)
  end

  def self.convert_to_array(raw_data)
    item_categories = Array.new
    raw_data.each do |row|
      item_category = ItemCategory.new({
        item_id: row['item_id'],
        category_id: row['category_id']
      })
      item_categories << item_category if item_category.valid?
    end
    item_categories
  end

  def to_s
    "ItemCategory @item_id = #{ @item_id } @category_id=#{ @category_id }"
  end
end