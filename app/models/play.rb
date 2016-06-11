class Play
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :bets

  def self.start_play
    weather = :nice # Temp
  	play = Play.new
  	players = Player.all
  	players.each do |p|
  		p.make_bet play, weather
  	end
  end
end
