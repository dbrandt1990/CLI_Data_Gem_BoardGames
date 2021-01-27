#CLI controller
class BoardGames::CLI 
    attr_accessor :games

    def call 
     list_games
     menu
     goodbye
    end

    def list_games 
        puts 'Top 10 boardgames:'
        #gets from the doc and list the games in order
        #fetch_games = BoardGames::API.new()
        #@games = fetch_games.fetch_games
        @games = [Game.new(title: "Spirit Island", price: "$80", year_published: "2019", players: "2-6", playtime: "90-120mins", min_age: "10+", description:"blank description", rules_url:"http://google.com"),
        Game.new(title: "Pandemic", price: "$35", year_published: "2010", players: "2-6", playtime: "60-90mins", min_age: "10+", description:"blank description")]
        @games.each_with_index{|game, i| puts "#{i+1}. #{game.title} - #{game.players} players"}
    end

    def menu 
        input  = nil
        while input != "exit"
        puts "Enter the number of the game you'd like to know more about, type list to see games again, or type 'exit'."
            input = gets.strip 

            if input == "list"
                list_games
            elsif @games[input.to_i - 1] && input.to_i != 0
               game = @games[input.to_i - 1] 
               puts "Title: #{game.title}" 
               puts "Price: #{game.price}"
               puts "Year: #{game.year_published}"
               puts "Players: #{game.players}" # min - max players ex: 2-6  min_players/max_players
               puts "Playtime: #{game.playtime}" #this should be the min - max ex: 90 - 120mins min_playtime/max_playtime
               puts "Ages: #{game.min_age}"
               puts "Description: #{game.description}"
               puts "Check the rulebook out here: #{game.rules_url}"
               
               puts "Find more games like this by typing 'find' the features you want filter by, EX: players, playtime, ages etc, or type list to start over."
            # gets input and applies it to find_by method then lists the games that fit the criteria.
            # take typed input, and grab the value of that attribute from the current game obj. pass both to find_by(attribute, value)
            # find_by(input, game.input) to get the attribute from input, and get the value from the current game obj
            else
                puts "Invalid input."
            end
         
        end
    end

    def goodbye 
        puts "Bye for now!"
    end
end