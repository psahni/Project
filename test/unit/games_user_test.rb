require File.dirname(__FILE__) + '/../test_helper'                    

class GamesUserTest < ActiveSupport::TestCase
  fixtures :games, :users, :games_users
  
  def test_presence
    games_user = GamesUser.new
    assert !games_user.valid?
    assert games_user.errors.invalid?(:user_id)
    assert games_user.errors.invalid?(:game_id)
  end
  
  def test_uniqueness
    games_user = GamesUser.new(:user_id => users(:quentin).id, :game_id => games(:mario).id, :status => RENTING_STATUS[:grabbed])
    assert !games_user.save
    assert_equal "The game is already in your list", games_user.errors.on(:user_id)
  end
  
  def test_belongs_to_user_and_game
    gu = GamesUser.new(:user_id => users(:saz).id, :game_id => games(:mario5).id, :status => RENTING_STATUS[:grabbed])
    assert gu.save
    gu.reload
    assert_equal users(:saz), gu.user
    assert_equal games(:mario5), gu.game
  end
  
  def test_notify_those_who_have_grabbed_and_not_rented
    g1 = GamesUser.create(:user_id => users(:qwertsaz).id, :game_id => games(:mario5).id, :status => RENTING_STATUS[:grabbed],:grabbed_at => 2.days.ago)
    g2 = GamesUser.create(:user_id => users(:saz).id, :game_id => games(:mariobros).id, :status => RENTING_STATUS[:grabbed],:grabbed_at => 2.days.ago)
    assert_equal 5, GamesUser.grabbed_and_not_rented_records.size
    assert_equal g1, GamesUser.remove_record(g1.id)
    assert_equal g2, GamesUser.remove_record(g2.id)
    assert 2, GamesUser.grabbed_and_not_rented_records.size
  end
  
  def test_shortlisted_can_be_grabbed_now
    g1 = GamesUser.create(:user_id => users(:new_user).id, :game_id => games(:free_game).id, :status => RENTING_STATUS[:grabbed], :grabbed_at => 2.days.ago)
    invalid_grabbed_games = GamesUser.grabbed_and_not_rented_records
    shortlisted_record = GamesUser.find_by_game_id(games(:free_game).id, :conditions => ['status=?', RENTING_STATUS[:shortlisted]])
    assert_not_nil shortlisted_record
    shortlisted_record.update_attribute(:status, RENTING_STATUS[:notified])
    assert_equal shortlisted_record.status, RENTING_STATUS[:notified]
    assert !GamesUser.find_by_id(g1)
  end

  def test_notified_but_not_grabbed
    invalid_shortlisted_games = GamesUser.notified_but_not_grabbed_records
    assert_equal 2, GamesUser.notified_but_not_grabbed_records.size
    invalid_shortlisted_games.each{|g| GamesUser.remove_record(g.id)}
    assert_equal 0, GamesUser.notified_but_not_grabbed_records.size
  end
  
end