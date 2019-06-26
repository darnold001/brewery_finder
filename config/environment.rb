require "sinatra/activerecord"
require "pry"
require "rest-client"
require "json"
require "require_all"

require_all "lib"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/development.db")

ActiveRecord::Base.logger = nil

api = BreweryAPI.new("https://api.openbrewerydb.org/breweries")
cli = CLI.new(api)
CLI.welcome_menu
