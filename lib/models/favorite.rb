class Favorite
    def self.add_prompt
        puts "Would you like to save this brewery"
        puts "'1' for Yes"
        puts "'2' for No"
        puts "'3' for Main menu"
        yn_response = gets.chomp
        case yn_response
        when "1"
            puts "Great, it's been added to your favorites list"
            CLI.add_lines
            CLI.brewery_add
            CLI.add_lines
        when "2"
            CLI.brewery_add
            CLI.add_lines
        when "3"
            CLI.user_menu
        else
            puts "Invalid input"
            CLI.add_lines
            add_prompt
        end
        CLI.select_for_info
        add_prompt
    end
end