class Options
  def self.initial_menu
    initial_response = gets.chomp
    case initial_response
    when "1"
      # new user
      CLI.get_and_set_user
      Database.add_user(@user_name)
      Prompt.add_lines
      CLI.user_menu
      CLI.goodbye
    when "2"
      # returning user
      puts "Welcome back! Please enter your name"
      Prompt.add_lines
      @user_name = gets.chomp.downcase
      @user_name = User.find_by name: @user_name
      puts "Hello #{@user_name.name.capitalize}!"
      CLI.user_menu
      CLI.goodbye
    when "3"
      Asci.goodbye
      CLI.goodbye
    else
      # invalid input
      puts "Invalid input"
      CLI.welcome_menu
    end
  end

  def self.user_menu
    user_menu_input = gets.chomp
    case user_menu_input
    when "1"
      CLI.favorite_menu
    when "2"
      CLI.get_city
    when "3"
      CLI.select_for_info
      Favorite.add_prompt
    when "4"
      CLI.goodbye
    else
      puts "Invalid input"
      CLI.user_menu
    end
  end
end
