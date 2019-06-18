class Brewery < ActiveRecord::Base
    has_many :favorite_breweries
    has_many :users, through: :favorite_breweries

    def self.cities(user_loc)
        city_reponse RestClient.get "https://api.openbrewerydb.org/breweries?by_city=#{user_loc}"
        @parsehash = JSON.parse(response_string)
        puts @parsehash
     end
end
