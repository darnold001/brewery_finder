# require "sinatra/activerecord"

class CLI
    def self.welcome
        puts "Welcome to our BFF app - Brewery Favorite Finder!"
        puts "What is your name?"
        @user_name = gets.chomp
        puts "What city are you drinking in?"
        @user_loc = gets.chomp
        add_user
    end

    def self.add_user
         User.create name: @user_name, location: @user_loc
    end

    def self.brewery_finder
        puts "Hello #{@user_name},"
        Brewery.list(@user_loc)
        Brewery.brewery_return
    end

end