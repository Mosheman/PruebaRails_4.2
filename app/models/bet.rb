class Bet
  include Mongoid::Document
  include Mongoid::Timestamps
  extend Enumerize

  field :amount, type: Integer, default: 0
  field :winner, type: Boolean
  field :betting_color
  enumerize :betting_color, in: [:green, :red, :black]

  belongs_to :player
  belongs_to :play

  def default_bet
	random_number = rand(8..15)
	apply_bet_amount random_number
  end

  def conservative_bet
  	random_number = rand(4..10)
  	apply_bet_amount random_number
  end

  def all_in all_money
  	self.amount = player.discount_money all_money
  end

  def apply_bet_amount random_number
  	p_money = player.money
	# => Seting de bet amount by: a bet percentage.
	## Its down rounded because there are no cents in CLP
	betting_amount = (p_money * (random_number * 0.01)).floor
	self.amount = player.discount_money betting_amount
	self.save
  end

end
