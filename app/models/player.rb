class Player
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :money, type: Integer, default: 10000

  has_many :bets

  def make_bet play, will_rain
  	my_bet = Bet.new
  	self.bets.push(my_bet)
  	play.bets.push(my_bet)
  	# => Little money => All in
  	if self.money <= 1000
  		my_bet.all_in self.money
  	else
  		# => Makes bet type by weather
	  	if will_rain
	  		my_bet.conservative_bet
	  	else
	  		my_bet.default_bet
	  	end
	end
  end

  def discount_money amount
  	self.money = self.money - amount
  	save
  	amount
  end

  def self.reset_money
  	Player.all.each do |p|
  		p.money = 10000
  		p.save
  	end
  end
end
