require './models/item.rb'
require './models/category.rb'
require './models/item_category.rb'

class CategoryController
  def self.show
    categories = Category.find_all
    renderer = ERB.new(File.read("./views/categories/list.erb"))
    renderer.result(binding)
  end

  def self.show_items(params) 
    category = Category.find_by_id(params['id'])[0]
    renderer = ERB.new(File.read("./views/categories/list_items.erb"))
    renderer.result(binding)
  end

  def self.new_form
    renderer = ERB.new(File.read("./views/categories/new.erb"))
    renderer.result(binding)
  end

  def self.edit_form(params)
    category = Category.find_by_id(params[:id])[0]
    renderer = ERB.new(File.read("./views/categories/edit.erb"))
    renderer.result(binding)
  end

  def self.create(params)
    category = Category.new({
      name: params[:name]
    })
    category.save
  end

  def self.update(params)
    category = Category.new({
      id: params[:id],
      name: params[:name]
    })
    category.save
  end

  def self.delete(params)
    category = Category.find_by_id(params['id'])[0]
    category.delete
  end
end