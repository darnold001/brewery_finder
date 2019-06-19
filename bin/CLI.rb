# require "sinatra/activerecord"

class CLI

    def self.menu
        puts "Welcome to our BFF app - Brewery Favorite Finder!"
        puts "Press 1 if you're a new user"
        puts "Press 2 if you're an existing user"
        puts "Press 3 to exit app"
        options
    end
    
    def self.options
        initial_response = gets.chomp
        if initial_response == "1"
            #new user
            get_name
            create_user
            get_city
        elsif initial_response == "2"
            #returning user
            puts "Welcome back! Please enter your name"
            user_name = gets.chomp.downcase
            User.find_by name: user_name
            user_menu
        elsif initial_response == "3"
            goodbye
        else
            #invalid input
            puts "Please enter 1 for new user, 2 for existing user or 3 to exit"
            options
        end
    end
    
    def self.get_name
        puts "What is your name?"
        @user_name = gets.chomp.downcase
    end
    
    def self.create_user
        @user = User.create name: @user_name
    end
    
    def self.create_brewery
        @brewery = Brewery.create name: @brewery_info
        FavoriteBrewery.create user: @user, brewery: @brewery
    end

    def self.get_city
        puts "What city are you drinking in?"
        @user_loc = gets.chomp
        brewery_finder
    end

    def self.brewery_finder
        puts "Hello #{@user_name.capitalize},"
        Brewery.list(@user_loc)
        Brewery.brewery_return
    end
    
    def self.brewery_info
        puts "Please enter the name of a brewery that you would like to learn more about:"
        @brewery_info = gets.chomp
        @requested_brewery_info = brewery.name_query (@brewery_info)
        puts requested_brewery_info
    end
    
    def self.add_favorite
        puts "Would you like to save this brewery -- y or n "
        loop do
            yn_response = gets.chomp
            case yn_response
            when "y"
                puts "Awesome, it's been added to your favorites list"
                create_brewery
                Brewery.select_brewery
            when "n"
                create_brewery
                Brewery.select_brewery
            else
                puts "I am sorry, that is not a valid entry. Please enter either yes or no"
            end
        end
    end

    def self.goodbye
        puts "Thanks for using BFF app"
        puts "Have a wonderful day"
        exit!
    end
end