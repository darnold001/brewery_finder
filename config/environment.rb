require "sinatra/activerecord"
require "pry"
require "rest-client"
require "json"
require "require_all"

require_all "lib"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: "db/development.db")

def run
    
end