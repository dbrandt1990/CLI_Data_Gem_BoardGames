# require 'httparty'
# class BoardGames::API 
#     include HTTParty
#     def fetch_games 
#         url = https://api.boardgameatlas.com/api/search?order_by=popularity&ascending=false&client_id=1vQCAipPrG
#         doc = HTTParty.get(url)
#         doc.map{|game| game.name}
#     end
# end