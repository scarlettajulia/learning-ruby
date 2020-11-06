require 'sinatra'
require './controllers/item_controller.rb'

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
  controller.new_food_form
end

get '/items/edit/:id' do 
  controller = ItemController.new
  controller.edit_food_form(params)
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
