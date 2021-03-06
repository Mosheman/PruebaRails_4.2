class Play
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize

  has_many :bets

  field :winning_color
  enumerize :winning_color, in: [:green, :red, :black]

  def self.start_play
    #binding.pry
    weather = Play.look_weather
    # People enter the game
  	players = Player.all - Player.where(:money => 0)
    # Everyone make his own bet
    play = Play.new
  	players.each do |p|
  		p.make_bet play, weather.will_rain
  	end
    # Spin the weel
    play.spin_the_weel
    # Pay winners
    play.bets.each do |b|
      if b.betting_color == play.winning_color
        play.pay_winner b
      end
    end
    play.save
  end

  def spin_the_weel
    number = rand(0..99)
    self.winning_color =  Play.choose_color_by number
  end

  def self.choose_color_by number
    case number
      when 0..1
        Play.winning_color.green
      when 2..50
        Play.winning_color.red
      when 51..99
        Play.winning_color.black
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

  def pay_winner bet
    if (Bet.betting_color.red == bet.betting_color) || (Bet.betting_color.black == bet.betting_color)
      bet.player.money += (bet.amount*2)
    elsif bet.betting_color == Bet.betting_color.green
      bet.player.money += (bet.amount*15)
    end
    bet.player.save
  end
end
