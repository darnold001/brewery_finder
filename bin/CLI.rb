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

    def self.add_favorite
        puts "Would you like to save one of these breweries to your profile? (yes/no)"
        yn_response = gets.chomp
        if yn_response == "yes"
            puts "Please enter the name of the brewery that you would like to save:"
            @brewery_fav = gets.chomp
            Brewery.create name: @brewery_fav
        elsif yn_response = "no"
            Brewery.brewery_info
        else puts "I am sorry, that is not a valid entry. Please enter either yes or no"
        end
    end

end