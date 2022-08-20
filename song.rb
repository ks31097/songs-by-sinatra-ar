require 'sinatra/activerecord'
require 'date'
require 'sinatra/flash'

configure :development do
  set :database, {adapter: "sqlite3", database: "development.sqlite3"}
end

class Song < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 4 }
  validates :lyrics, presence: true, length: { minimum: 5 }
  validates :length, presence: true
  validates :datestamp, presence: true
end

get '/songs' do
  @songs = Song.all
  erb :songs
end

get '/songs/new' do
  unless session[:admin]
    flash[:notice] = "You are not logged in!"
    redirect to("/login")
  else
    @song = Song.new
    erb :new_song
  end
end

post '/songs/new' do
  @song = Song.new params[:song]
  if @song.save
    redirect to("/songs/#{@song.id}")
  else
  @error = @song.errors.full_messages
    erb :new_song
  end
end

get '/songs/:id' do
  @song = Song.find(params[:id])
  erb :show_song
end

get '/songs/:id/edit' do
  unless session[:admin]
    flash[:notice] = "You are not logged in!"
    redirect to("/login")
  else
    @song = Song.find(params[:id])
    erb :edit_song
  end
end

put '/songs/:id' do
  @song = Song.find(params[:id])
  @song.update(params[:song])
  redirect to("/songs/#{@song.id}")
end

delete '/songs/:id' do
  unless session[:admin]
    flash[:notice] = "You are not logged in!"
    redirect to("/login")
  else
    @song = Song.find(params[:id])
    @song.destroy
    redirect to('/songs')
  end
end
