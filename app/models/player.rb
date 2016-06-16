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
  		# => Makes bet amount type by weather
	  	if will_rain
	  		my_bet.conservative_bet
	  	else
	  		my_bet.default_bet
	  	end
	end
	# => Choose color where the bet is placed
	number = rand(0..99)
	my_bet.betting_color = Play.choose_color_by number
	my_bet.save

	self.save
  end

  def discount_money amount
  	self.money = self.money - amount
  	self.save
  	amount
  end

  def self.refill_money
  	Player.all.each do |p|
  		p.money += 10000
  		p.save
  	end
  end

  # def choose_betting_color
  # 	# => Assumptions where made: the players choose color at same rate
  # 	number = rand(0..29)
  # 	case number
		# when 0..9
		# 	Bet.betting_color.green
		# when 10..19
		# 	Bet.betting_color.red
		# when 20..29
		# 	Bet.betting_color.black
  #   end
  # end

end
