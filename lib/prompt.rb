class Prompt
  def self.initial_menu
    add_lines
    puts "Welcome to our BFF app - Brewery Favorite Finder!"
    puts "Enter 1 if you're a new user"
    puts "Enter 2 if you're an existing user"
    puts "Enter 3 to exit app"
    add_lines
  end
  def self.user_menu
    add_lines
    puts "User Menu"
    puts "Select 1 for favorites Menu"
    puts "Select 2 to search for a list of breweries in a city"
    puts "Select 3 to search for a brewery by name"
    puts "Select 4 to Exit"
    add_lines
  end
  def self.add_lines
    puts "----------------------------------------------------------------------------"
  end
end
