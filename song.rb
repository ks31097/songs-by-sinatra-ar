require 'sinatra/activerecord'
require 'date'

configure :development do
  set :database, {adapter: "sqlite3", database: "development.sqlite3"}
end

class Song < ActiveRecord::Base
end


get '/songs' do
  @songs = Song.all
  erb :songs
end

get '/songs/new' do
  @song = Song.new
  erb :new_song
end

post '/songs/new' do
  @song = Song.new params[:song]
  if @song.save
    redirect to("/songs/#{@song.id}")
  else
    @error = @song.errors.full_messages.first
    erb :new_song
  end
end

get '/songs/:id' do
  @song = Song.find(params[:id])
  erb :show_song
end

get '/songs/:id/edit' do
  @song = Song.find(params[:id])
  erb :edit_song
end

put '/songs/:id' do
  @song = Song.find(params[:id])
  @song.update(params[:song])
  redirect to("/songs/#{@song.id}")
end

delete '/songs/:id' do
  @song = Song.find(params[:id])
  @song.destroy
  redirect to('/songs')
end
