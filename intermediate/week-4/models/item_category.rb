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
    if item_category.nil?
      client.query("insert into item_categories (item_id, category_id) values ('#{ @item_id }', '#{ @category_id }')")
    end
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
    return nil if raw_data.count == 0
    item_categories = convert_to_array(raw_data)
    return item_categories.count > 1 ? item_categories : item_categories[0]
  end

  def self.find_all
    client = create_db_client
    raw_data = client.query ("select items.id as item_id, category_id from items left join item_categories on items.id = item_categories.item_id")
    return [] if raw_data.count == 0
    item_categories = convert_to_array(raw_data)
    return item_categories.count > 1 ? item_categories : item_categories[0]
  end

  def self.convert_to_array(raw_data)
    item_categories = Array.new
    raw_data.each do |row|
      if row['item_id'].nil? and row['category_id'].nil?
        next
      end
      item_category = ItemCategory.new({
        item_id: row['item_id'],
        category_id: row['category_id']
      })
      item_categories << item_category
    end
    item_categories
  end

  def to_s
    "ItemCategory @item_id = #{ @item_id } @category_id=#{ @category_id }"
  end
end