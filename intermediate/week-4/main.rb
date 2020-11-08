require 'sinatra'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/application_controller.rb'

get '/' do 
  controller = ApplicationController.home
end

get '/items' do
  controller = ItemController.show
end

get '/items/detail/:id' do
  controller = ItemController.detail(params)
end

get '/items/new' do
  controller = ItemController.new_form
end

get '/items/edit/:id' do 
  controller = ItemController.edit_form(params)
end

get '/items/delete/:id' do
  controller = ItemController.delete(params)
  redirect '/items'
end

post '/items/create' do
  controller = ItemController.create(params)
  redirect '/items'
end

post '/items/update/:id' do
  controller = ItemController.update(params)
  redirect '/items'
end

get '/categories' do
  controller = CategoryController.show
end

get '/categories/items/:id' do
  controller = CategoryController.show_items(params)
end

get '/categories/detail/:id' do
  controller = CategoryController.detail(params)
end

get '/categories/new' do
  controller = CategoryController.new_form
end

get '/categories/edit/:id' do 
  controller = CategoryController.edit_form(params)
end

get '/categories/delete/:id' do
  controller = CategoryController.delete(params)
  redirect '/categories'
end

post '/categories/create' do
  controller = CategoryController.create(params)
  redirect '/categories'
end

post '/categories/update/:id' do
  controller = CategoryController.update(params)
  redirect '/categories'
end
