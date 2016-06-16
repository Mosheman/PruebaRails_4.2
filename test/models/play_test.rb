require 'test_helper'

class PlayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	Bet.delete_all
  	Player.delete_all
  	Play.delete_all
  	Weather.delete_all

    @bet_one = Bet.new
    @bet_two = Bet.new
    @player_one = Player.new :name => "Testman", :money => 1000
    @player_two = Player.new :name => "aQAman", :money => 1000
    @play = Play.new

  	@player_one.bets.push(@bet_one)
  	@player_two.bets.push(@bet_two)
  	@play.bets.push(@bet_one)
  	@play.bets.push(@bet_two)

  	@player_one.save
  	@player_two.save
    @play.save
    @bet_one.save
    @bet_two.save
  end
  #####################################
  # => Relations
  #####################################
  test "Bettings Play" do
  	assert_equal 2, @play.bets.all.size
  	assert_equal @bet_one, @play.bets.first
  	assert_equal @bet_two, @play.bets.last
  end
  #####################################
  # => Methods
  #####################################
  test "make_bet" do
  	Bet.delete_all
  	@play.start_play
  	assert_equal 2, @play.bets.all.size
  end

  test "self.look_weather" do
  	assert_equal 0, Weather.all.size
  	Play.look_weather
  	assert_equal 1, Weather.all.size
  end

  test "spin_the_weel" do
    assert_equal nil, @play.winning_color
    @play.spin_the_weel
    assert_not_equal nil, @play.winning_color
  end

  test "choose_color_by" do
    assert_equal Play.winning_color.green, @play.choose_color_by(1)
    assert_equal Play.winning_color.red, @play.choose_color_by(14)
    assert_equal Play.winning_color.black, @play.choose_color_by(77)
  end
end
