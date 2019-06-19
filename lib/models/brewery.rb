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
            get_city
        elsif breweries.count == 1
            puts "You have one brewery in your area:"
            puts name_query(breweries[0])
            CLI.add_favorite
        elsif breweries.count == 50
            puts "Wow, there are 50 or more breweries in your city:"
            puts breweries
            select_brewery
            CLI.add_favorite
        else
            puts "You have #{breweries.count} breweries to choose from:"
            puts breweries
            select_brewery
            CLI.add_favorite
        end
    end

    def self.select_brewery
        puts "Please enter the name of the brewery you'd like to know more about"
        
        @selected_brewery = gets.chomp
        name_query (@selected_brewery)
    end

    def self.name_query (name)
        jquery = RestClient.get "https://api.openbrewerydb.org/breweries?by_name=#{name}"
        JSON.parse(jquery)
    end
end
