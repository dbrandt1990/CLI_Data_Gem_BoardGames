class BoardGames::Game
    attr_reader :image, :name, :price, :year_published, :players, :playtime, :min_age, :description, :rules_url

    @@all = []

    def initialize(image ="N/A", name ="N/A", price ="N/A", year_published ="N/A", players ="N/A", playtime ="N/A", min_age ="N/A", description ="N/A", rules_url ="No Rulebook PDF availible :(")
        @image = image
        @name = name
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
end