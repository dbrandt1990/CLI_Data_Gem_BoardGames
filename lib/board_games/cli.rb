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

    def filter_menu
        puts "\n-------WELCOME TO THE FILTER MENU--------\n"
        puts "TYPE A COMMAND FROM BELOW AND HIT ENTER:
        ---price
        ---year_published
        ---players
        ---playtime
        ---age"
        
        input = gets.strip
    
        case input 
          when "price"
            puts "\nEnter a maximum price ex 20"
            input = gets.strip
            filtered_games = @games.select{|game| game.price.to_f  <= input.to_f}
          when "year_published"
            puts "\nEnter a year and see the if any of the top 100 games came out that year!"
          when "players"
            puts "\nEnter the min and max number of players ex 1-5"
          when "playtime"
            puts "\nEnter the min and max playtime in minutes ex 60-120"
          when "min_age"
            puts "\nEnter the minnimum age requirement you'd like"
        end
        list_games(filtered_games)
    end


    def menu
        number = 10 #default 10, if 'more'/'less' is typed, add/remove 10 to this to change the length of game list.
        input  = nil
        while input != "exit"
        puts "Enter the number of the game you'd like to know more about, type 'list' to  view games again, 'list more' or 'less to see more or less games  or type 'exit'."

            input = gets.strip 

            if input == "filter"
                filter_menu
            elsif input == "list"
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

            #maybe try t oput this (displaying and getting more info from games) to it's own method, so it could be used in the filter menu
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