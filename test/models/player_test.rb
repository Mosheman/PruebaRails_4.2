require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @bet_one = Bet.new
    @player = Player.new :name => "Testman", :money => 1000
    @play = Play.new

  	@player.bets.push(@bet_one)
  	@play.bets.push(@bet_one)

  	@player.save
    @play.save
    @bet_one.save
  end
  #####################################
  # => Relations
  #####################################
  test "Bettings Player" do
  	assert_equal 1, @player.bets.all.size
  	assert_equal @bet_one, @player.bets.first
  end
  #####################################
  # => Methods
  #####################################
  test "make_bet" do
  	@player.make_bet @play, false
  	assert_equal 0, @player.money
  	assert_equal 1000, @player.bets.last.amount
  end

  test "discount_money" do
  	@player.discount_money 999
  	assert_equal 1, @player.money
  end

  test "self.reset_money" do
  	Player.reset_money
  	assert_equal 10000, Player.last.money
  end

  # test "choose_betting_color" do
  #   assert_equal Enumerize::Value, @player.choose_betting_color.class
  # end
end
