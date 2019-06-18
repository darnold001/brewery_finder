class User < ActiveRecord::Base
    has_many :favorite_breweries
    has_many :breweries, through: :favorite_breweries
end