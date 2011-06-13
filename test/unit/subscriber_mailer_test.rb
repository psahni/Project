require File.dirname(__FILE__) + '/../test_helper'

class SubscriberMailerTest < ActionMailer::TestCase
fixtures :users  
 tests SubscriberMailer 
  def test_signup_notification
    user = users(:quentin)
    email = SubscriberMailer.deliver_signup_notification(user)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [user.email], email.to
    assert_equal "Registration for gamesite", email.subject
  end
  
  def test_account_activation
    user = users(:quentin)
    email = SubscriberMailer.deliver_account_activation(user)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [user.email], email.to
    assert_equal "Account activation notification", email.subject
  end
  
  def test_reset_notification
    user = users(:quentin)
    email = SubscriberMailer.deliver_reset_notification(user)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Link to reset your password", email.subject
    assert_instance_of MatchData,email.body.match(/http:\/\/ajax4u.com\/reset\/56cff93ca673b50e4392cc7d2f515941217d070f/) 
  end
  
  def test_grab_notification
    gu = GamesUser.new(:game_id => games(:mario3).id, :user_id => users(:raju).id, :status => RENTING_STATUS[:grabbed])
    email = SubscriberMailer.deliver_grab_notification(gu.user, gu.game)
    count = ActionMailer::Base.deliveries.size
    gu.save
    assert ActionMailer::Base.deliveries.size, count + 1
    assert_equal "[gamesite] Grabbed game "+"[#{gu.game.name}]", email.subject
  end
  
  def test_grab_notification_not_sent
    gu = GamesUser.new(:game_id => 5, :user_id => 2, :status => RENTING_STATUS[:rented])
    count = ActionMailer::Base.deliveries.size
    gu.save
    assert ActionMailer::Base.deliveries.size, count
  end
  
  def test_subscription_notification
    user = users(:quentin)
    email = SubscriberMailer.deliver_subscription_notification(user)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Your subscription is about to expire.", email.subject
  end
  
  def test_subscription_cancelled_notification
    user = users(:quentin)
    email = SubscriberMailer.deliver_subscription_cancelled_notification(user)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Your subscription has been cancelled.", email.subject
  end
  
  def test_subscription_renewal_notification
    user = users(:quentin)
    time = Date.today
    email = SubscriberMailer.deliver_subscription_renewal_notification(user, time)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Your subscription has been renewed.", email.subject
  end
  
  def test_not_rented_notification
    invalid_grabbed_games = GamesUser.grabbed_and_not_rented_records
    count = ActionMailer::Base.deliveries.size
    assert_equal 0,count
    invalid_grabbed_games.each{
    |game| email = SubscriberMailer.deliver_not_rented_notification(game.user, game.game)
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "[gamesite] Rent game "+"[#{game.game.name}]",email.subject
    count = ActionMailer::Base.deliveries.size
    assert_match /You have not rented #{game.game.name}./,email.body
    }
    assert_equal invalid_grabbed_games.size,count

  end
  
  def test_notification_to_shortlisted_users
    invalid_grabbed_games = GamesUser.grabbed_and_not_rented_records
    invalid_grabbed_games.each do |game|
    shortlisted_records = GamesUser.find(:all,:conditions => ['status=? and game_id = ?',RENTING_STATUS[:shortlisted],game.game_id])
    shortlisted_records.each do |sgame|
      email  = SubscriberMailer.deliver_notification_to_shortlisted_users(sgame.user, sgame.game)
      assert_equal "[gamesite] Shortlisted game "+"[#{sgame.game.name}]",email.subject
      assert !ActionMailer::Base.deliveries.empty?
      end
    end
  end

  def test_not_grabbed_notification
    invalid_shortlisted_games = GamesUser.notified_but_not_grabbed_records
    invalid_shortlisted_games.each do |shortlisted_game|
      email = SubscriberMailer.deliver_not_grabbed_notification(shortlisted_game.user, shortlisted_game.game) 
      assert_equal "[gamesite] Grab game "+"[#{shortlisted_game.game.name}]",email.subject
      assert !ActionMailer::Base.deliveries.empty?
      assert_match /You have not grabbed #{shortlisted_game.game.name}/,email.body
    end
  end
    
end
