require 'test_helper'

class BetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @bet = Bet.new
    @player = Player.new :name => "Testman", :money => 1000
    @play = Play.new

  	@player.bets.push(@bet)
  	@play.bets.push(@bet)
  end
  #####################################
  # => Relations
  #####################################
  test "Players Bet" do
  	assert_equal @player, @bet.player
  end

  test "Plays Bet" do
  	assert_equal @play, @bet.play
  end
  #####################################
  # => Methods
  #####################################
  test "all_in" do
  	assert_equal 1000, @player.money
  	assert_equal 0, @bet.amount
  	@bet.all_in @player.money
  	assert_equal 0, @player.money
  	assert_equal 1000, @bet.amount
  end

  test "apply_bet_amount" do
  	@bet.apply_bet_amount 10
  	# betting_amount = (p_money * (random_number * 0.01)).floor
  	assert_equal 100, @bet.amount
  	assert_equal 900, @player.money
  end
end
