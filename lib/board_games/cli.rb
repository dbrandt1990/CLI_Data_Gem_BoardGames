require_relative './game.rb'
require_relative './api.rb'

class BoardGames::CLI 

    def call 
     create_games_list
     list_games(@games)
     menu
     goodbye
    end

    def create_games_list 
        BoardGames::API.new().create_game_objects
        @games = BoardGames::Game.all
        puts "Sorry, there was an error loading the games list." if @games == []
    end

    def list_games(games, number = 10)
        puts "\nTop #{number} boardgames:" 
        games.each_with_index do |game, i|
            if i < number
            puts "#{i + 1}. #{game.name}"
            end
        end
    end

    # def valid_filter_input(input)
    #     if input[0] && input[1] 
    #        true
    #     end
    # end

    # def filter_games(attribute, value)
 
    #    list_games(@games.map{|game| game.year_published == value})
    # end
    
    # def filter_menu
    #     puts "\n-------WELCOME TO THE FILTER MENU--------\n"
    #     puts "TYPE the attribute followed by a comma, and then the value you'd like to filter by (limit 1):
    #     ---price, $100 <-maximum price
    #     ---year_published, 2002 <- year published
    #     ---players, 1 - 5 <- min and max players
    #     ---playtime, 60 - 90 <- min and max playtime in minutes
    #     ---min_age, 13 <- min age"

    #     input = gets.strip
    #     input = input.split(',')
    #     if valid_filter_input(input)
    #     attribute = input[0].strip
    #     value = input[1].strip  
    #     filter_games(attribute,value)
    #     else
    #         puts "INVALID input, please be sure to use the formate given."
    #     end
    # end


    def menu
        number = 10 #default 10, if 'more'/'less' is typed, add/remove 10 to this to change the length of game list.
        input  = nil
        while input != "exit"
        puts "Enter the number of the game you'd like to know more about, type 'list' to  view games again, 'list more' or 'less to see more or less games  or type 'exit'."

            input = gets.strip 

            if input == "list"
                list_games(@games, number)
            elsif input == "list more"
                number += 10
                list_games(@games, number)
                if number == 100
                    puts "\n!!!THE LIST ONLY GOES TO 100!!!\n"
                end
            elsif input == "less"
                number -= 10 if number > 10
                list_games(@games, number)


            elsif @games[input.to_i - 1] && input.to_i != 0 && input.to_i <= number
               game = @games[input.to_i - 1] 
               puts "\n 'CLICK TO SEE IMAGE #{game.image}"
               puts "\nName: #{game.name}" 
               puts "Price: $#{game.price}"
               puts "Year: #{game.year_published}"
               puts "Players: #{game.players}"
               puts "Playtime: #{game.playtime} minutes" 
               puts "Ages: #{game.min_age}+"
               
               puts "\nTO FIND OUT MORE ABOUT THIS GAME, TYPE 'more', or type 'list' to view games again \n\n"

               input = gets.strip
               
               if input.downcase == "more"
                puts "\n#{game.description} \n\n"
                puts "\nCheck the rulebook out here: #{game.rules_url}\n\n"
               elsif input.downcase == "list"
                list_games(@games, number)
               end
            else
                puts "Invalid input."
            end
        end
    end

    def goodbye 
        puts "Bye for now!"
    end
end