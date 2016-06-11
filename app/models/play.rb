class Play
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :bets

  def self.start_play
  	play = Play.new
	players = Player.all
	players.each do |p|
		p.make_bet play
	end
  end
end
