require 'sinatra'
require 'sinatra/reloader' if development?
require './song'

set :public_folder, 'assets'

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

helpers do
  def current?(path='/')
    (request.path==path || request.path==path+'/') ? 'nav-link px-2 link-secondary' : 'nav-link px-2 link-dark'
  end

  def set_title
    @title ||= 'Songs By Sinatra'
  end
end

before do
  set_title
end

# get '/set/:name' do
#   session[:name] = params[:name]
# end
#
# get '/get/hello' do
#   "Hello #{session[:name]}"
# end

get '/' do
  erb :home
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/contacts' do
  @title = "Contact Us"
  erb :contacts
end

get '/login' do
  @title = "Login"
  erb :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
    else
    flash.now[:'error-message'] = "Enter the correct username and password!"
    erb :login
  end
end

get '/logout' do
  session.clear
  redirect to('/')
end

not_found do
  erb :not_found
end
