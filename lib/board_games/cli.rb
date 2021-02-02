require_relative './game.rb'
require_relative './api.rb'
require 'colorize'

class BoardGames::CLI 

    def call 
        create_games_list
        list_games
        menu
        goodbye
    end

    def create_games_list 
        BoardGames::API.new().create_game_objects
        @games = BoardGames::Game.all
        puts "Sorry, there was an error loading the games list.".red if @games == []
    end

    def list_games(number = 10)
        puts "\n\t======== Current Top #{number.to_s.green} boardgames ========".bold
        @games.each_with_index do |game, i|
            if i < number
                puts "\t\t\s\s\s\s#{i + 1}. #{game.name}"
            end
        end
    end 

    def help_message
         puts "\n- #{'list'.green} = reprint current game list in console"
         puts "- #{'list more'.green} = adds 10 games to the current game list"
         puts "- #{'less'.green} = removes 10 games from current game list, minnimum of 10"
         puts "- #{'exit'.green} = exits CLI and clears console"
    end


    def menu
        number = 10 #default 10, if 'more'/'less' is typed, add/remove 10 to change the length of game list.
        input = nil #set input so while loop will start
        while input != "exit"
            puts "\nEnter the number of the game you'd like to know more about, or type #{'help'.yellow} for a list of commands:"

            input = gets.strip.downcase 

            if input == "help"
                help_message

            elsif input == "list"
                list_games(number)

            elsif input == "list more"
                number += 10
                list_games(number)
                if number == 100
                    puts "\n!!!THE LIST ONLY GOES TO 100!!!\n".yellow
                end
                
            elsif input == "less"
                number -= 10 if number > 10
                list_games(number)

            elsif input == "exit"
                system("clear")

            elsif @games[input.to_i - 1] && input.to_i !=0 && input.to_i <= number
                game = @games[input.to_i - 1] 
                puts "\n 'CLICK TO SEE IMAGE #{game.image.cyan}"
                puts "\nName: #{game.name}" 
                puts "Price: $#{game.price}"
                puts "Year: #{game.year_published}"
                puts "Players: #{game.players}"
                puts "Playtime: #{game.playtime} minutes" 
                puts "Ages: #{game.min_age}+"
                
                puts "\nTO FIND OUT MORE ABOUT THIS GAME, TYPE #{"'more'".yellow} or press #{"'ENTER'".green} and type a new command.\n\n"
 
                input = gets.strip.downcase

                if input == "more"
                    puts "\t\t\t=== #{game.name.upcase.bold.green.underline} ==="
                    puts "\n#{game.description} \n\n"
                    puts "\nCheck the rulebook out here: #{game.rules_url.cyan}\n\n" if game.rules_url
                elsif input == "help"
                    help_message
                elsif input == "list"
                    list_games(number)
               end
            else
                puts "INVALID INPUT".red
                puts "Type #{'help'.yellow} for a list of commands"
            end
        end
    end

    def goodbye 
        puts "\t\t\ === See you next time! ===".cyan
    end
end