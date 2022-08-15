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
  erb :about
end

get '/contact' do
  erb :contact
end
