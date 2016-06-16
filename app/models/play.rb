class Play
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize

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
    self.spin_the_weel
    # Pay to winners

  end

  def spin_the_weel
    number = rand(0..99)
    winner_color_by number
  end

  def winner_color_by number
    case number
      when 0..1
        self.winning_color = Play.winning_color.green
      when 2..50
        self.winning_color = Play.winning_color.red
      when 51..99
        self.winning_color = Play.winning_color.black
    end
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
