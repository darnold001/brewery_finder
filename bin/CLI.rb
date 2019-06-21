class CLI

    
    def self.welcome_menu
        Asci.art
        puts "Welcome to our BFF app - Brewery Favorite Finder!"
        puts "Press 1 if you're a new user"
        puts "Press 2 if you're an existing user"
        puts "Press 3 to exit app"
        puts "-------------------------------------------------------------------------"
        options
    end
    
    def self.options 
        initial_response = gets.chomp
        case initial_response
        when "1"
            # new user
            user_get_name
            user_add
            user_menu
        when "2"
            # returning user
            puts "Welcome back! Please enter your name"
            puts "-------------------------------------------------------------------------"
            @user_name = gets.chomp.downcase
            @user_name = User.find_by name: @user_name
            puts "Hello #{@user_name.name.capitalize}!"
            user_menu
        when "3"
            goodbye
        else
            # invalid input
            puts "Invalid input"
            welcome_menu
        end
    end
    
    def self.user_menu
        puts "User Menu"
        puts "Select 1 for Favorites Menu"
        puts "Select 2 to search for a list of breweries in a city"
        puts "Select 3 to search for a brewery by name"
        puts "Select 4 to Exit"
        puts "-------------------------------------------------------------------------"
        user_menu_input = gets.chomp
        case user_menu_input
        when "1"
            favorite_menu
        when "2"
            get_city
        when "3"
            select_for_info
            Favorite.add_prompt
        when "4"
            goodbye
        else
            puts "Invalid input"
            user_menu
        end
    end
    
    def self.favorite_menu
        puts "Favorite Menu"
        puts "Here is a list of your favorite breweries:"
        puts "-------------------------------------------------------------------------"
        puts @user_name.breweries.pluck :name
        puts "-------------------------------------------------------------------------"
        puts "Options:"
        puts "1 to get more info on a brewery"
        puts "2 delete a brewery from your list"
        puts "3 delete entire brewery list"
        puts "4 to exit"
        puts "-------------------------------------------------------------------------"
        favorite_input = gets.chomp
        case favorite_input
        when "1"
            select_for_info
        when "2"
            puts "please enter the name of the brewery you would like to delete:"
            puts "-------------------------------------------------------------------------"
            delete_input = gets.chomp
            to_delete = Brewery.find_by name: delete_input
            FavoriteBrewery.find_by(brewery_id: to_delete.id).destroy
            to_delete.destroy
            puts "--------------------------Brewery Deleted------------------------------------"
            favorite_menu
        when "3"
            breweries_to_delete = []
            brewery_ids = FavoriteBrewery.where user_id: @user_name.id
            breweries_to_delete << @user_name.breweries.pluck(:id)
            brewery_ids.delete_all
            breweries_to_delete.flatten.each {|id| (Brewery.find id).delete}
            puts "-------------------Favorites List Destroyed --------------------------"
            favorite_menu
        when "4" 
            goodbye
        else
            puts "Invalid input"
            favorite_menu
        end
    end

    def self.goodbye
        puts "Thanks for using BFF app"
        puts "Cheers"
        exit!
    end

    def self.select_for_info
        puts "Please enter the name of a brewery that you would like to learn more about:"
        puts "or enter 'main' to return to main menu"
        puts "-------------------------------------------------------------------------"
        @brewery_info = gets.chomp
        user_menu if @brewery_info == "main"
        @requested_brewery_info = name_query (@brewery_info)
        puts @requested_brewery_info
    end
    
    def self.brewery_add
        @brewery = Brewery.create name: @brewery_info
        FavoriteBrewery.create user: @user_name, brewery: @brewery
    end

    def self.get_city
        puts "What city are you drinking in?"
        @user_loc = gets.chomp
        list(@user_loc)
        results
    end
    
    def self.list(user_loc)
        city_reponse = RestClient.get "https://api.openbrewerydb.org/breweries?by_city=#{user_loc}&per_page=50 "
        @parsehash = JSON.parse(city_reponse)
    end
    
    def self.results
        @breweries = []
        @parsehash.each {|key, value| @breweries << key["name"]}
        if @breweries.count == 0
            puts "-------------------------------------------------------------------------"
            puts "Sorry, no breweries in your area."
            puts "-------------------------------------------------------------------------"
            get_city
        elsif @breweries.count == 1
            puts "-------------------------------------------------------------------------"
            puts "You have one brewery in your area:"
            puts name_query(@breweries[0])
            puts "-------------------------------------------------------------------------"
            Favorite.add_prompt
        elsif @breweries.count == 50
            puts "-------------------------------------------------------------------------"
            puts "Wow, there are 50 or more breweries in your city:"
            puts @breweries
            puts "-------------------------------------------------------------------------"
            select_for_info
            Favorite.add_prompt
        else
            puts "-------------------------------------------------------------------------"
            puts "You have #{@breweries.count} breweries to choose from:"
            puts @breweries
            puts "-------------------------------------------------------------------------"
            select_for_info
            Favorite.add_prompt
        end
    end
    
    def self.name_query (name)
        jquery = RestClient.get "https://api.openbrewerydb.org/breweries?by_name=#{name}"
        json = JSON.parse(jquery)
        info = json[0].each_with_object ({}) do |(k,v), hash|
             hash[k] = v unless k == "id" || k == "longitude" || k == "latitude" || k == "tag_list"
        end
        info.each {|k,v| puts "#{k}: #{v}"}
        puts "-------------------------------------------------------------------------"
    end

    def self.user_get_name
        puts "What is your name?"
        @user_name = gets.chomp.downcase
    end
    
    def self.user_add
        @user_name = User.create name: @user_name
    end
end