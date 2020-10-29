require 'mysql2'
require 'mysql2-cs-bind'
require_relative 'model/category'
require_relative 'model/item'

def create_db_client
  client = Mysql2::Client.new(
    :host => 'localhost',
    :username => 'your_username',
    :password => 'your_password',
    :database => 'food_oms_db'
  )
  client
end

def get_items 
  client = create_db_client
  raw_data = client.query("select id, name, format(price, 0) as price from items")
  items = Array.new
  raw_data.each do |data|
    item = Item.new(data['name'], data['price'], data['id'])
    items << item
  end
  items
end

def get_categories
  client = create_db_client
  raw_data = client.query ("select id, name from categories")
  categories = Array.new
  raw_data.each do |data|
    category = Category.new(data['name'], data['id'])
    categories << category
  end 
  categories
end

def get_items_categories 
  client = create_db_client
  raw_data = client.query("select items.id, items.name, format(items.price, 0) as price, 
    categories.name as category_name, categories.id as category_id 
    from items left join item_categories on items.id = item_id 
    left join categories on category_id = categories.id")
  items = Array.new
  raw_data.each do |data|
    category = Category.new(data['category_name'], data['category_id'])
    item = Item.new(data['name'], data['price'], data['id'], category)
    items << item
  end
  items
end

def get_items_category(id) 
  client = create_db_client
  raw_data = client.xquery("select items.id, items.name, format(items.price, 0) as price, 
    categories.name as category_name, categories.id as category_id 
    from items left join item_categories on items.id = item_id 
    left join categories on category_id = categories.id where items.id = ?", id)
  raw_data.each do |data|
    category = Category.new(data['category_name'], data['category_id'])
    item = Item.new(data['name'], data['price'], data['id'], category)
    return item
  end
end

def create_new_item(name, price, category_id)
  client = create_db_client
  price.to_s.gsub!(',', '.')
  client.xquery("insert into items (name, price) values (?, ?)", name, price)
  raw_data = client.query('select last_insert_id()')
  raw_data.each do |data|
    id = data["last_insert_id()"]
    client.xquery("insert into item_categories (item_id, category_id) values (?, ?)", id, category_id)
  end
end

def delete_item(id)
  client = create_db_client
  client.xquery("delete from order_details where item_id = ?", id)
  client.xquery("delete from item_categories where item_id = ?", id)
  client.xquery("delete from items where id = ?", id)
end

def update_item(id, name, price, category_id)
  client = create_db_client
  price.to_s.gsub!(',', '')
  client.xquery("update items set name = ?, price = ? where id = ?", name, price, id)
  raw_data = client.xquery("select * from item_categories where item_id = ?", id)
  if raw_data.count == 0
    client.xquery("insert into item_categories (item_id, category_id) values (?, ?)", id, category_id)
  else
    client.xquery("update item_categories set item_id = ?, category_id = ? where item_id = ?", id, category_id, id)
  end
end