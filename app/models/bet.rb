class Bet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :amount, type: Integer
  filed :color_cd, type: Integer
  field :winner, type: Boolean

  belongs_to :player
  belongs_to :play

  as_enum :color, {
	  :green => 0,
	  :red => 1,
	  :black => 2
  }

  def default_bet
	random_number = rand(8..15)
	apply_bet random_number
  end

  def conservative_bet
  	random_number = rand(4..10)
  	apply_bet random_number
  end

  def all_in all_money
  	self.amount = player.discount_money all_money
  end

  def apply_bet random_number
  	p_money = player.money
	# => Seting de bet amount by: a bet percentage.
	## Its down rounded because there are no cents in CLP
	betting_amount = (p_money * (random_number * 0.01)).floor

	self.amount = player.discount_money betting_amount
	save
  end

end
