require 'sinatra'

=begin
Implementation of previous messages for next time reference
get '/messages' do 
  '<h1 style ="background-color:Salmon;">Hello world!</h1>'
end

get '/messages/:name' do 
  name = params['name']
  color = params['color'] ? params['color'] : 'Salmon'
  "<h1 style=\"background-color:#{color};\">Hello #{name}!</h1>"
end
=end

get '/messages' do
  erb :message, locals: {
    :color => 'DodgerBlue',
    :name => 'World!'
  }
end

get '/messages/:name' do 
  name = params['name'].capitalize
  color = params['color'].nil? ? 'Salmon' : params['color']
  erb :message, locals: {
    :color => color,
    :name => name
  }
end

get '/login_form' do
  erb :login_form 
end

post '/login' do 
  if params['username'] == 'admin' && params['password'] == 'admin' 
    return 'Logged in'
  else
    redirect '/login_form'
  end
end