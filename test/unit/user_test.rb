require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  fixtures :all
  
  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_email_invalid
    u = create_user(:email => 'abc')
    assert_equal "is too short (minimum is 6 characters)", u.errors.on(:email)[0]
    assert_equal "should look like an email address.", u.errors.on(:email)[1]
  end

  def test_email_uniqueness
    assert_no_difference 'User.count' do
      u = create_user(:email => 'quentin@example.com')
      assert_equal "has already been taken", u.errors.on(:email)
    end
  end
  

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_password_length
    assert_no_difference 'User.count' do
      u = User.new({ :name => "quire", :email => 'quire@example.com', :password => "123456", :password_confirmation => "123456", :phone => 9292929292, :dob => Date.today })
      u.valid?
      assert_equal "is too short (minimum is 8 characters)", u.errors.on(:password)
    end
  end

  def test_should_require_phone
    assert_no_difference 'User.count' do
      u = create_user(:phone => nil)
      assert u.errors.on(:phone)
    end
  end

  def test_invalid_phone
    assert_no_difference 'User.count' do
      u = create_user(:phone => 1292929292)
      assert u.errors.on(:phone)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:quentin), User.authenticate('quentin@example.com', 'new password')
  end

  def test_should_not_rehash_password
    users(:quentin).update_attributes(:email => 'quentin2@yahoo.com')
    assert_equal users(:quentin).crypted_password, '4ae9e21a8f0c68c1ad0af495cfe677eb21100b28'
  end

  def test_should_set_remember_token
      users(:quentin).remember_me
      assert_not_nil users(:quentin).remember_token
      assert_not_nil users(:quentin).remember_token_expires_at
    end

  def test_should_unset_remember_token
      users(:quentin).remember_me
      assert_not_nil users(:quentin).remember_token
      users(:quentin).forget_me
      assert_nil users(:quentin).remember_token
    end

    def test_should_remember_me_for_one_week
      before = 1.week.from_now.utc
      users(:quentin).remember_me_for 1.week
      after = 1.week.from_now.utc
      assert_not_nil users(:quentin).remember_token
      assert_not_nil users(:quentin).remember_token_expires_at
      assert users(:quentin).remember_token_expires_at.between?(before, after)
    end

    def test_should_remember_me_until_one_week
      time = 1.week.from_now.utc
      users(:quentin).remember_me_until time
      assert_not_nil users(:quentin).remember_token
      assert_not_nil users(:quentin).remember_token_expires_at
      assert_equal users(:quentin).remember_token_expires_at, time
    end
  
  def test_create_reset_code
    @user = users(:user_with_no_game)
    @user.create_reset_code
    assert_not_nil @user.reset_code 
    assert_equal true,@user.recently_reset?
  end
  
  def test_delete_reset_code
    @user = users(:user_with_no_game)
    @user.create_reset_code
    @user.delete_reset_code
    assert_nil @user.reset_code
  end
  
  def test_renewed_if_game_not_rented
    @user = users(:saz)
    @user.update_attribute(:is_active, false)
    count = SubscriptionRenewal.count
    @user.renewed
    assert_equal count+1, SubscriptionRenewal.count
    assert SubscriberMailer.deliver_subscription_renewal_notification(@user, Date.today)
    assert_equal true, @user.is_active
  end
  
  def test_renewed_if_game_rented
    @user = users(:quentin)
    @user.update_attribute(:is_active, false)
    count = SubscriptionRenewal.count
    @user.renewed
    assert_equal count+1, SubscriptionRenewal.count
    assert SubscriberMailer.deliver_subscription_renewal_notification(@user, @user.subscription_renewals.last.renewed_on)
    assert_equal true, @user.is_active
  end
  
  def test_has_one_grabbed_game
    u = users(:quentin)
    assert u.grabbed_game
  end
  
  def test_user_has_many_subscriptions
    u = users(:quentin)
    assert u.subscription_renewals
  end
  
  def test_has_one_rented_game
    u = users(:quentin)
    assert u.rented_game
  end
  
  def test_has_many_shortlisted_games
    u = users(:aaron)
    before_shortlisted_games = u.shortlisted_games.count
    u.shortlisted_games << games(:mario6)
    assert_equal before_shortlisted_games+1, u.shortlisted_games.count
  end
  
  def test_has_many_subscribed_games
    u = users(:aaron)
    before_subscribed_games = u.subscribed_games.count
    u.games_users << GamesUser.create(:game => games(:mario), :user => u, :status => RENTING_STATUS[:subscribed])
    assert_equal before_subscribed_games+1, u.subscribed_games.count
  end
  
  def test_has_many_notified_games
    u = users(:aaron)
    before_notified_games = u.notified_games.count
    u.games_users << GamesUser.create(:game => games(:mario), :user => u, :status => RENTING_STATUS[:notified])
    assert_equal before_notified_games+1, u.notified_games.count
  end
  
  def test_has_many_games_users
    u = users(:quentin)
    assert u.games_users
  end
  
  def test_has_many_games
    u = users(:quentin)
    assert u.games
  end
  
  def test_attr_accessible_reading
    new_user = User.new
    assert_nothing_raised{new_user.email}
    assert_nothing_raised{new_user.name}
    assert_nothing_raised{new_user.password}
    assert_nothing_raised{new_user.password_confirmation}
    assert_nothing_raised{new_user.dob}
    assert_nothing_raised{new_user.is_active}
    assert_nothing_raised{new_user.identification_token}
  end
  
  def test_attr_accessible_writing
    new_user = User.new
    assert_nothing_raised{new_user.email = "attr@test.com"}
    assert_nothing_raised{new_user.name = "test"}
    assert_nothing_raised{new_user.password = "attribute"}
    assert_nothing_raised{new_user.password_confirmation = "attribute"}
    assert_nothing_raised{new_user.dob = Date.today}
    assert_nothing_raised{new_user.is_active = 1}
    token = User.make_token
    assert_nothing_raised{ new_user.identification_token = token }
    assert_equal("attr@test.com", new_user.email)
    assert_equal("test", new_user.name)
    assert_equal(Date.today, new_user.dob)
    assert_equal(true, new_user.is_active)
    assert_equal(token, new_user.identification_token)
  end

  def test_remove_shortlisted_game
    @user = users(:singh)
    assert_equal 5,@user.shortlisted_games.count
    game_to_delete = @user.shortlisted_games.first
    @user.remove_shortlisted_game(game_to_delete)
    assert_equal 4,@user.shortlisted_games.count
  end
  
  def test_generation_of_identification_token
    token  = User.make_identification_token
    assert_equal 10,token.size
    assert_match /[a-zA-Z]+[\d]*/,token
  end
  
  def test_uniqueness_of_identification_token
    u = users(:aaron)
    create_user(:identification_token => u.identification_token)
    u1 = User.last
    assert_not_equal u.identification_token,u1.identification_token
  end

  protected
  
  def create_user(options = {})
    record = User.new({ :name => "quire", :email => 'quire@example.com', :password => 'quirequire', :password_confirmation => 'quirequire', :phone => 9292929292, :dob => Date.today }.merge(options))
    record.save
    record
  end
end