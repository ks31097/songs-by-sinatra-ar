require 'sinatra/activerecord'
require 'date'

configure :development do
  set :database, {adapter: "sqlite3", database: "development.sqlite3"}
end

class Song < ActiveRecord::Base
end
