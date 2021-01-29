require_relative './game.rb'
require_relative './api.rb'
require 'colorize'

class BoardGames::CLI 

    def call 
     create_games_list
     list_games(@games)
     menu(@games)
     goodbye
    end

    def create_games_list 
        BoardGames::API.new().create_game_objects
        @games = BoardGames::Game.all
        puts "Sorry, there was an error loading the games list.".red if @games == []
    end

    def list_games(games, number = 10)
        puts "\n\t======== Current Top #{number.to_s.green} boardgames ========".bold
        games.each_with_index do |game, i|
            if i < number
            puts "\t\t\s\s\s\s#{i + 1}. #{game.name}"
            end
        end
    end 

    def help_message
        puts "\n- #{'filter'.green} = opens menu to filter game list"
        puts "- #{'list'.green} = reprint current game list in console"
         puts "- #{'list more'.green} = adds 10 games to the current game list"
         puts "- #{'less'.green}= removes 10 games from current game list, minnimum of 10"
         puts "- #{'exit'.green} = leaves filtered list, if filter is applied, else exits CLI and clears console"
    end

    def filter_menu
        puts "\n-------WELCOME TO THE FILTER MENU--------\n".green
        puts "TYPE A COMMAND FROM BELOW AND HIT ENTER:
        ---price
        ---year
        ---players
        ---playtime
        ---age".yellow
        
        input = gets.strip.downcase
        input_valid = true
    
        case input 
          when "price"
            puts "\nType a maximum price #{'ex: 20'.red}"
            input = gets.strip
            filtered_games = @games.select{|game| game.price.to_f  <= input.to_f}
          when "year"
            puts "\nType a year and see the if any of the top 100 games came out that year!"
            input = gets.strip
            filtered_games = @games.select{|game| game.year_published.to_i  <= input.to_i}
          when "players"
            puts "\nType the min and max number of players #{'ex: 1-5'.red}"
            input = gets.strip.split('-')
            filtered_games = @games.select{|game| players = game.players.split('-')  
            players[0].to_i >= input[0].to_i && players[1].to_i <= input[1].to_i}
          when "playtime"
            puts "\nType the min and max playtime in minutes #{'ex: 60-90'.red}"
            input = gets.strip.split('-')
            filtered_games = @games.select{|game| pt = game.playtime.split('-')  
            pt[0].to_i >= input[0].to_i && pt[1].to_i <= input[1].to_i}
          when "age"
            puts "\nType the minnimum age requirement you'd like"
            input = gets.strip.downcase
            filtered_games ||= @games.select{|game| game.min_age.to_i  <= input.to_i}
          when "help"
            help_message
            filter_menu
          else 
            input_valid = false
            puts "INVALID INPUT".red
            puts "Type #{'help'.yellow} for a list of commands"
            filter_menu
        end
        if input_valid
            list_games(filtered_games)
            menu(filtered_games, filter_mode = 1)
        end
    end

    def menu(games, filter_mode = 0)
        number = 10 #default 10, if 'more'/'less' is typed, add/remove 10 to this to change the length of game list.
        filter_mode == 2 ? input = "exit" : input = nil # start with nil input to allow while loop to begin, or set to exit after exiting so the loop will end

        while input != "exit"
        puts "\n\t\tType 'exit' to remove filter".blue if filter_mode == 1
        puts "\nEnter the number of the game you'd like to know more about, or type #{'help'.yellow} for a list of commands:"

            input = gets.strip.downcase 

            if input == "filter"
                if filter_mode == 0
                   filter_menu
                else 
                    filter_menu
                    input = "exit"
                end
            elsif input == "help"
                help_message
            elsif input == "list"
                list_games(games, number)
            elsif input == "list more"
                number + 10 <= games.length - 1 ? number += 10 : number = games.length - 1
                list_games(games, number)
                if number == 100
                    puts "\n!!!THE LIST ONLY GOES TO 100!!!\n".yellow
                end
            elsif input == "less"
                number -= 10 if number > 10
                list_games(games, number)
            elsif input == "exit" && filter_mode == 0 || filter_mode == 2
                system("clear")
            elsif input == "exit" && filter_mode == 1
                list_games(@games)
                puts "\t\tDisplaying unfiltered list".blue
                menu(@games, filter_mode = 2)
            #maybe try t oput this (displaying and getting more info from games) to it's own method, so it could be used in the filter menu
            elsif games[input.to_i - 1] && input.to_i !=0 && input.to_i <= number
               game = games[input.to_i - 1] 
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
                list_games(games, number)
               end
            else
                puts "INVALID INPUT".red
                puts "Type #{'help'.yellow} for a list of commands"
            end
        end
    end

    def goodbye 
        puts "\t\t\ === See you next time! ==="
    end
end