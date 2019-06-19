require "sinatra/activerecord"
require "pry"
require "rest-client"
require "json"
require "require_all"

require_all "lib"
require_all "bin"


ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/development.db")


CLI.welcome
CLI.brewery_finder
CLI.add_favorite

# def run
    
# end