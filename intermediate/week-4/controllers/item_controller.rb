require './models/item.rb'
require './models/category.rb'
require './models/item_category.rb'

class ItemController
  def show
    items = Item.find_all
    renderer = ERB.new(File.read("./views/list_items.erb"))
    renderer.result(binding)
  end

  def detail(params) 
    item = Item.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/detail_item.erb"))
    renderer.result(binding)
  end

  def new_food_form
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/new_item.erb"))
    renderer.result(binding)
  end

  def edit_food_form(params)
    categories = Category.find_all
    item = Item.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/edit_item.erb"))
    renderer.result(binding)
  end

  def save_item_category(params)
    categories = Category.find_all
    categories.each do |category|
      key = 'category' + category.id.to_s
      item_category = ItemCategory.new({
        item_id: params['id'],
        category_id: category.id
      })
      if params.keys.include?(key)
        item_category.save
      else
        item_category.delete
      end
    end
  end

  def create(params)
    item = Item.new({
      name: params['name'],
      price: params['price']
    })
    item.save
    params['id'] = item.id
    save_item_category(params)
  end

  def update(params)
    item = Item.new({
      id: params['id'],
      name: params['name'],
      price: params['price']
    })
    item.save
    save_item_category(params)
  end

  def delete(params)
    item = Item.new({
      id: params['id']
    })
    item.delete
  end
end