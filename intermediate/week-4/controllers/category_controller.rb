require './models/item.rb'
require './models/category.rb'
require './models/item_category.rb'

class CategoryController
  def show
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/categories/list.erb"))
    renderer.result(binding)
  end

  def show_items(params) 
    category = Category.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/categories/list_items.erb"))
    renderer.result(binding)
  end

  def new_form
    renderer = ERB.new(File.read("./views/categories/new.erb"))
    renderer.result(binding)
  end

  def edit_form(params)
    category = Category.find_by_id(params['id'])
    renderer = ERB.new(File.read("./views/categories/edit.erb"))
    renderer.result(binding)
  end

  def create(params)
    category = Category.new({
      name: params['name']
    })
    category.save
  end

  def update(params)
    category = Category.new({
      id: params['id'],
      name: params['name']
    })
    category.save
  end

  def delete(params)
    category = Category.new({
      id: params['id']
    })
    category.delete
  end
end