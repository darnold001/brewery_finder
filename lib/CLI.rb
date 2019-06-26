class CLI
  def initialize(breweryAPI)
    @@breweryAPI = breweryAPI
  end

  def self.welcome_menu
    Asci.art
    Prompt.initial_menu
    Options.initial_menu
  end

  def self.user_menu
    Asci.menu
    Prompt.user_menu
    Options.user_menu
  end

  def self.favorite_menu
    add_lines
    puts Asci.favorite
    puts "Favorite Menu"
    add_lines
    puts "Here is a list of your favorite breweries:"
    add_lines
    puts @user_name.breweries.pluck :name
    add_lines
    puts "Options:"
    puts "Enter 1 to get more info on a brewery"
    puts "Enter 2 delete a brewery from your list"
    puts "Enter 3 delete entire brewery list"
    puts "Enter 4 to go back to Main menu"
    puts "Enter 5 to exit"
    add_lines
    favorite_input = gets.chomp
    case favorite_input
    when "1"
      select_for_info
      favorite_menu
    when "2"
      puts "please enter the name of the brewery you would like to delete:"
      add_lines
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
      breweries_to_delete.flatten.each { |id| (Brewery.find id).delete }
      puts "-------------------Favorites List Destroyed --------------------------"
      user_menu
    when "4"
      user_menu
    when "5"
      goodbye
    else
      puts "Invalid input"
      favorite_menu
    end
  end

  def self.goodbye
    add_lines
    puts Asci.goodbye
    puts "Thanks for using BFF app"
    puts "Cheers"
    add_lines
    exit!
  end

  def self.select_for_info
    puts "Please enter the name of a brewery that you would like to learn more about:"
    puts "Or enter '1' for Main menu"
    add_lines
    @brewery_info = gets.chomp
    add_lines
    @brewery_info == "1" ? user_menu : (puts name_query(@brewery_info))
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
    puts @@breweryAPI
    city_reponse = @@breweryAPI.get_by_location(user_loc)
    @parsehash = JSON.parse(city_reponse)
  end

  def self.results
    @breweries = []
    @parsehash.each { |key, value| @breweries << key["name"] }
    if @breweries.count == 0
      add_lines
      puts "Sorry, no breweries in your area."
      add_lines
      get_city
    elsif @breweries.count == 1
      add_lines
      puts "You have one brewery in your area:"
      add_lines
      puts name_query(@breweries[0])
      Favorite.add_prompt
    elsif @breweries.count == 50
      add_lines
      puts "Wow, there are 50 or more breweries in your city:"
      add_lines
      puts @breweries
      select_for_info
      Favorite.add_prompt
    else
      add_lines
      puts "You have #{@breweries.count} breweries to choose from:"
      add_lines
      puts @breweries
      select_for_info
      Favorite.add_prompt
    end
  end

  def self.name_query(name)
    jquery = RestClient.get "https://api.openbrewerydb.org/breweries?by_name=#{name}"
    json = JSON.parse(jquery)
    if json == []
      puts "I am sorry, there are no breweries that match that name; please ensure that the name is spelled correctly."
    else info = json[0].each_with_object ({}) do |(k, v), hash|
      hash[k] = v unless k == "id" || k == "longitude" || k == "latitude" || k == "tag_list"
    end
      info.each { |k, v| puts "#{k}: #{v}" }
      add_lines     end
  end

  def self.get_and_set_user
    puts "What is your name?"
    @user_name = gets.chomp.downcase
  end

  def self.add_lines
    puts "----------------------------------------------------------------------------"
  end
end
