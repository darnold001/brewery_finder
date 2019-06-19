class Brewery < ActiveRecord::Base
    has_many :favorite_breweries
    has_many :users, through: :favorite_breweries

    def self.list(user_loc)
        city_reponse = RestClient.get "https://api.openbrewerydb.org/breweries?by_city=#{user_loc}&per_page=50 "
        @parsehash = JSON.parse(city_reponse)
    end
    
    def self.brewery_return
        breweries = []
        @parsehash.each {|key, value| breweries << key["name"]}
        count = breweries.count
        case count
        when count == 0
            puts "Sorry, no breweries in your area."
        when count == 1
            puts "Hey, you have one brewery in your area:"
        else
            puts "Hey, you have #{count} breweries:"
        end
        puts breweries
    end
end
