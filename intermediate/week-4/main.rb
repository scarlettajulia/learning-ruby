require 'sinatra'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/application_controller.rb'

get '/' do 
  controller = ApplicationController.new
  controller.home
end

get '/items' do
  controller = ItemController.new
  controller.show
end

get '/items/detail/:id' do
  controller = ItemController.new
  controller.detail(params)
end

get '/items/new' do
  controller = ItemController.new
  controller.new_form
end

get '/items/edit/:id' do 
  controller = ItemController.new
  controller.edit_form(params)
end

get '/items/delete/:id' do
  controller = ItemController.new
  controller.delete(params)
  redirect '/items'
end

post '/items/create' do
  controller = ItemController.new
  controller.create(params)
  redirect '/items'
end

post '/items/update/:id' do
  controller = ItemController.new
  controller.update(params)
  redirect '/items'
end

get '/categories' do
  controller = CategoryController.new
  controller.show
end

get '/categories/items/:id' do
  controller = CategoryController.new
  controller.show_items(params)
end

get '/categories/detail/:id' do
  controller = CategoryController.new
  controller.detail(params)
end

get '/categories/new' do
  controller = CategoryController.new
  controller.new_form
end

get '/categories/edit/:id' do 
  controller = CategoryController.new
  controller.edit_form(params)
end

get '/categories/delete/:id' do
  controller = CategoryController.new
  controller.delete(params)
  redirect '/categories'
end

post '/categories/create' do
  controller = CategoryController.new
  controller.create(params)
  redirect '/categories'
end

post '/categories/update/:id' do
  controller = CategoryController.new
  controller.update(params)
  redirect '/categories'
end
