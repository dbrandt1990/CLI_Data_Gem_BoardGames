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

    def menu 
        number = 10 #default 10, if 'more'/'less' is typed, add/remove 10 to this to change the length of game list.
        input  = nil
        while input != "exit"
        puts "Enter the number of the game you'd like to know more about, type 'list' to  view games again, 'more'/'less to see more or less games  or type 'exit'."
            input = gets.strip 

            if input == "list"
                list_games(@games, number)

            elsif input == "more"
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
               puts "\nName: #{game.name}" 
               puts "Price: $#{game.price}"
               puts "Year: #{game.year_published}"
               puts "Players: #{game.players}"
               puts "Playtime: #{game.playtime} minutes" 
               puts "Ages: #{game.min_age}"
               puts "\nCheck the rulebook out here: #{game.rules_url}"
               
               puts "\nTO FIND OUT MORE ABOUT THIS GAME, TYPE 'DESCRIPTION', or type 'list' to view games again \n\n"
               input = gets.strip
               if input.downcase == "description"
                puts "\n#{game.description} \n\n"
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