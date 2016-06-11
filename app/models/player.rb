class Player
  include Mongoid::Document
  field :name, type: String
  field :money, type: Integer, default: 10000

  has_many :bets

  def make_bet play
  	my_bet = self.bets.new
  end
end
