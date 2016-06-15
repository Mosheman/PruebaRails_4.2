class Play
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :bets

  field :winning_color
  enumerize :winning_color, in: [:green, :red, :black]

  def start_play
    #binding.pry
    weather = Play.look_weather
    # People enter the game
  	players = Player.all
    # Everyone make his own bet
  	players.each do |p|
  		p.make_bet self, weather.will_rain
  	end
    # Spin the weel

  end

  def self.look_weather
    weather = Weather.last
    weather_created_at = weather ? weather.created_at.to_date : nil

    # => If there are no Weather records or, the created_at date is not todays => Create a Forecast record.
    if Weather.empty? or (weather_created_at != Date.today)
      weather = Weather.new
      weather.query
      weather.is_raining_soon_until 7
      weather.save
    end
    weather
  end

end
