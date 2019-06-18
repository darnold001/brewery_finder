require "sinatra/activerecord"

class Main_Menu
    def self.welcome
        puts "Welcome to  our BFF app - Brewery Favorite Finder!"
        puts "What is your name?"
        @user_name = gets.chomp
        puts "What city are you drinking in?"
        @user_loc = gets.chomp
        add_user
    end

    def self.add_user
        User.create(:name => @user_name.downcase, :locations => @user_loc.downcase)
    end

end