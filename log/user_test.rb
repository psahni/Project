require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :users

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
    assert_no_difference 'User.count' do
      u = create_user(:email => 'abc')
      assert_equal "is too short (minimum is 6 characters)", u.errors.on(:email)[0]
      assert_equal "should look like an email address.", u.errors.on(:email)[1]
    end
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
      u = create_user(:password => 123456, :password_confirmation => 123456)
      assert_equal "is too short (minimum is 8 characters)", u.errors.on(:password)
    end
  end
  
  def test_should_require_phone
    assert_no_difference 'User.count' do
      u = create_user(:phone => nil)
      assert u.errors.on(:phone)
    end
  end
  
  def test_should_require_cheque_no
    assert_no_difference 'User.count' do
      u = create_user(:cheque_no => nil)
      assert u.errors.on(:cheque_no)
    end
  end
  
  def test_should_require_bank_name
    assert_no_difference 'User.count' do
      u = create_user(:bank_name => nil)
      assert u.errors.on(:bank_name)
    end
  end
  
  def test_should_require_bank_branch
    assert_no_difference 'User.count' do
      u = create_user(:bank_branch => nil)
      assert u.errors.on(:bank_branch)
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

  # def test_should_reset_password
  #     users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
  #     assert_equal users(:quentin), User.authenticate('quentin', 'new password')
  #   end

  def test_should_not_rehash_password
    users(:quentin).update_attributes(:email => 'quentin2@yahoo.com')
    assert_equal users(:quentin).crypted_password, '552761481a75862203cbd4589af3064262408c9a'
  end
 
  # def test_should_set_remember_token
  #     users(:quentin).remember_me
  #     assert_not_nil users(:quentin).remember_token
  #     assert_not_nil users(:quentin).remember_token_expires_at
  #   end

  # def test_should_unset_remember_token
  #     users(:quentin).remember_me
  #     assert_not_nil users(:quentin).remember_token
  #     users(:quentin).forget_me
  #     assert_nil users(:quentin).remember_token
  #   end

  # def test_should_remember_me_for_one_week
  #     before = 1.week.from_now.utc
  #     users(:quentin).remember_me_for 1.week
  #     after = 1.week.from_now.utc
  #     assert_not_nil users(:quentin).remember_token
  #     assert_not_nil users(:quentin).remember_token_expires_at
  #     assert users(:quentin).remember_token_expires_at.between?(before, after)
  #   end

  # def test_should_remember_me_until_one_week
  #     time = 1.week.from_now.utc
  #     users(:quentin).remember_me_until time
  #     assert_not_nil users(:quentin).remember_token
  #     assert_not_nil users(:quentin).remember_token_expires_at
  #     assert_equal users(:quentin).remember_token_expires_at, time
  #   end
    
  # def test_should_remember_me_default_two_weeks
  #     before = 2.weeks.from_now.utc
  #     users(:quentin).remember_me
  #     after = 2.weeks.from_now.utc
  #     assert_not_nil users(:quentin).remember_token
  #     assert_not_nil users(:quentin).remember_token_expires_at
  #     assert users(:quentin).remember_token_expires_at.between?(before, after)
  #   end

protected
  def create_user(options = {})
    record = User.new({ :name => "quire", :email => 'quire@example.com', :password => 'quirequire', :password_confirmation => 'quirequire', :phone => 9292929292, :cheque_no => "1234asdf", :bank_name => "PNB", :bank_branch => 'Delhi' }.merge(options))
    record.save
    record
  end
end
