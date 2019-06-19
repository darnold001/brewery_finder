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
        if breweries.count == 0
            puts "Sorry, no breweries in your area."
        elsif breweries.count == 1
            puts "You have one brewery in your area:"
        elsif breweries.count == 50
            puts "Wow, there are 50 or more breweries in your city:"
        else
            puts "You have #{breweries.count} breweries to choose from:"
        end
        puts breweries
    end

    def self.brewery_info
        puts "Please enter the name of a brewery that you would like to learn more about:"
        @brewery_selection = gets.chomp
        brew_info = RestClient.get "https://api.openbrewerydb.org/breweries?by_name=#{@brewery_selection}"
        requested_info = JSON.parse(brew_info)
        puts requested_info
    end
end
