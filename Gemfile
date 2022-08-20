# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby "3.0.4"

gem "sinatra", "~> 2.2"
gem "sinatra-contrib", "~> 2.2"
gem "thin", "~> 1.8"
gem "puma", "~> 5.6"
gem "reel", "~> 0.6.1"
gem "http", "~> 5.1"
gem "webrick", "~> 1.7"
gem "bootstrap", "~> 5.2"
gem "activerecord", "~> 7.0"
gem "sinatra-activerecord", "~> 2.0"
gem "rake", "~> 13.0"
gem "sinatra-flash", "~> 0.3.0"

group :development do
  gem "sqlite3", "~> 1.4"
end

group :production do
  gem "pg", "~> 1.4.3"
end
