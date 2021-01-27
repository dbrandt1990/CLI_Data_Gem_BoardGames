class BoardGames::CLI::Game
    attr_reader :title, :price, :year_published, :players, :playtime, :min_age, :description, :rules_url
    # include HTTParty
    @@all = []

    def initialize(title:"N/A", price:"N/A", year_published:"N/A", players:"N/A", playtime:"N/A", min_age:"N/A", description: "N/A", rules_url:"No Rulebook PDF availible :(")
        @title = title 
        @price = price
        @year_published = year_published
        @players = players 
        @playtime = playtime 
        @min_age = min_age 
        @description = description 
        @rules_url = rules_url
        @@all << self
    end

    def self.all 
        @@all 
    end

    def self.find_by(attribute, value)
        self.all.collect do |game|
            game.attribute == value
        end
    end
end