require 'sinatra'
require './db_connector'

get '/' do
  items = get_items_categories
  erb :list_items, locals: {
    items: items
  }
end

get '/items' do
  items = get_items_categories
  erb :list_items, locals: {
    :items => items
  }
end

get '/items/new' do
  categories = get_categories
  erb :new_item, locals: {
    :categories => categories
  }
end

get '/items/detail/:id' do
  item_id = params[:id]
  item = get_items_category(item_id)
  erb :detail_item, :locals => {
    :item => item
  }
end

get '/items/delete/:id' do
  item_id = params[:id]
  delete_item(item_id)
  redirect '/'
end

get '/items/edit/:id' do 
  item = get_items_category(params[:id])
  categories = get_categories
  erb :edit_item, :locals => {
    :item => item,
    :categories => categories
  }
end

post '/items/create' do
  name = params['name']
  price = params['price']
  category_id = params["category"]
  create_new_item(name, price, category_id)
  redirect '/'
end

post '/items/update/:id' do
  item_id = params[:id]
  name = params['name']
  price = params['price']
  category_id = params["category"]
  update_item(item_id, name, price, category_id)
  redirect '/'
end
