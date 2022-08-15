require 'sinatra'
require 'sinatra/reloader' if development?

set :public_folder, 'assets'

before do
  @title = "Songs By Sinatra"
end

get '/' do
  erb :home
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/contact' do
  @title = "Contact Us"
  erb :contact
end

not_found do
  erb :not_found
end
