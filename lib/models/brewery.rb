

class Brewery

    def self.cities(city)
       city_reponse RestClient.get "https://api.openbrewerydb.org/breweries?by_city=#{city}"
       @parsehash = JSON.parse(response_string)
       puts @parsehash
    end

class Brewery < ActiveRecord::Base
    has_many :favorite_breweries
    has_many :users, through: :favorite_breweries
end
