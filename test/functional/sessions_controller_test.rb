require File.dirname(__FILE__) + '/../test_helper'
require 'sessions_controller'
class SessionsController; def rescue_action(e) raise e end; end

class SessionsControllerTest < ActionController::TestCase
  fixtures :users

  def setup
    @controller = SessionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_login_and_redirect
    post :create, :email => 'saz@vinsol.com', :password => 'qazwsxed'
    assert_equal "Logged in successfully",flash[:notice]
    assert session[:user_id] 
    session[:user_id] = nil
  end

  def test_logged_in_user_should_not_able_to_go_on_signup_page
    post :create, :email => 'raju@example.com', :password => 'qazwsxed' 
    assert_equal "Logged in successfully", flash[:notice]
    assert session[:user_id] 
    get :create
    assert_equal "You are already logged in.", flash[:notice]
  end

  def test_should_not_login_and_with_wrong_credentials
    post :create, :email => 'quentin', :password => 'bad password'
    assert_nil session[:user_id]
    assert_equal "Invalid email/password combination.", flash[:error]
  end

  def test_for_login_attempt_by_user_who_is_not_active
    post :create,:email => 'aaron@example.com',:password => "qwert123"
    assert_equal "Your account has not been activated yet.",flash[:notice]
  end

  def test_should_logout
    post :create, :email => "saz@vinsol.com", :password => "qazwsxed"
    assert_equal 4,session[:user_id]
    get :destroy
    assert_redirected_to "/"
    assert_nil session[:user_id]
  end

  def test_should_remember_me
    @request.cookies["auth_token"] = nil
    post :create, {:email => 'raju@example.com', :password => 'qazwsxed', :remember_me => "1"}
    assert_not_nil @response.cookies["auth_token"]
  end

  def test_should_not_remember_me
    @request.cookies["auth_token"] = nil
    post :create, :email => 'quentin', :password => 'bhardwaj', :remember_me => "0"
    assert @response.cookies["auth_token"].blank?
  end

  def test_should_delete_token_on_logout
    login_as :quentin
    get :destroy
    assert @response.cookies["auth_token"].blank?
  end

  def test_should_login_with_cookie
    users(:quentin).remember_me
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :new
    assert @controller.send(:logged_in?)
  end

  def test_should_fail_expired_cookie_login
    users(:quentin).remember_me
    users(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    @request.cookies["auth_token"] = cookie_for(:quentin)
    get :new
    assert !@controller.send(:logged_in?)
  end

  def test_should_fail_cookie_login
    users(:quentin).remember_me
    @request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :new
    assert !@controller.send(:logged_in?)
  end

  def test_logged_in_user_should_not_able_to_go_on_signup_page
    post :create, :email => 'saz@vinsol.com', :password => 'qazwsxed'
    assert_equal "Logged in successfully",flash[:notice]
    assert session[:user_id] 
    get :new
    assert_redirected_to games_path
  end

  protected
  def auth_token(token)
    CGI::Cookie.new('name' => 'auth_token', 'value' => token)
  end

  def cookie_for(user)
    auth_token users(user).remember_token
  end
end
