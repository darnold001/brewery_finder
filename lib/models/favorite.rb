class Favorite
    def self.add_prompt
        puts "Would you like to save this brewery -- 'yes', 'no' or 'main' for main menu"
        yn_response = gets.chomp
        case yn_response
        when "yes"
            puts "Awesome, it's been added to your favorites list"
            CLI.brewery_add
        when "no"
            CLI.brewery_add
        when "main"
            CLI.user_menu
        else
            puts "Invalid input"
            add_prompt
        end
        CLI.select_for_info
        add_prompt
    end
end