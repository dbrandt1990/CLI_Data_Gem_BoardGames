require_relative './game.rb'
require 'httparty'

class BoardGames::API
    include HTTParty

    def fetch_games 
        url = "https://api.boardgameatlas.com/api/search?order_by=popularity&ascending=false&client_id=1vQCAipPrG"
        doc = HTTParty.get(url)
        data = doc.parsed_response
        #usting index of 1 to get into games list, data is {'games'[{gameobjects}]}
        data["games"]
    end
    
    def create_game_objects
        fetch_games.each_with_index do |game, i|
            image = game['image_url']
            name = game['name']
            price = game['price']
            year_published = game['year_published']
            players = "#{game['min_players']}-#{game['max_players']}"
            playtime = "#{game['min_playtime']}-#{game['max_playtime']}"
            min_age = "#{game['min_age']}"
            description = game['description_preview'].gsub('"',"'").strip 
            rules_url = game['rules_url']
            BoardGames::Game.new(image, name, price, year_published, players, playtime, min_age, description, rules_url)
        end
    end
end