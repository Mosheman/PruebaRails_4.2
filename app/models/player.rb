class Player
  include Mongoid::Document
  field :name, type: String
  field :money, type: Integer, default: 10000

  has_many :bets

  def make_bet play, weather
  	my_bet = self.bets.new
  	# => Makes bet type by weather
  	if weather == :nice
  		my_bet.default_bet play
  	else
  		my_bet.conservative_bet play
  	end
  end

  def apply_bet amount
  	money = money - amount
  end
end
