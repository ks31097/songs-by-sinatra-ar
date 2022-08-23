require 'sinatra/activerecord'
require 'date'
require 'sinatra/flash'
require 'active_record'

configure :development do
  set :database, {adapter: "sqlite3", database: "development.sqlite3"}
end

class Song < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 4 }
  validates :lyrics, presence: true, length: { minimum: 5 }
  validates :length, presence: true
  validates :datestamp, presence: true
end

module SongHelpers
  def find_songs
    @songs = Song.all
  end

  def find_song
    @song = Song.find(params[:id])
  end
end

helpers SongHelpers

get '/songs' do
  find_songs
  erb :songs
end

get '/songs/new' do
  unless session[:admin]
    flash.next[:'error-message'] = "You are not logged in!"
    redirect to("/login")
  else
    @song = Song.new
    erb :new_song
  end
end

post '/songs/new' do
  @song = Song.new params[:song]
  if @song.save
    flash.next[:notice] = "Song successfully added"
    redirect to("/songs/#{@song.id}")
  else
    @error = @song.errors.full_messages
    erb :new_song
  end
end

get '/songs/:id' do
  find_song
  erb :show_song
end

get '/songs/:id/edit' do
  unless session[:admin]
    flash.next[:'error-message'] = "You are not logged in!"
    redirect to("/login")
  else
    find_song
    erb :edit_song
  end
end

put '/songs/:id' do
  find_song
  @song.update(params[:song])
  flash.next[:notice] = "Song successfully updated"
  redirect to("/songs/#{@song.id}")
end

delete '/songs/:id' do
  unless session[:admin]
    flash.next[:'error-message'] = "You are not logged in!"
    redirect to("/login")
  else
    find_song
    flash.next[:notice] = "Sond deleted!"
    find_song.destroy
    redirect to('/songs')
  end
end
