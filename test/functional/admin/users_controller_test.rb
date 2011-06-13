require File.dirname(__FILE__) + '/../../test_helper'

require 'admin/users_controller'

class Admin::UsersControllerTest < ActionController::TestCase
  fixtures :all

  def test_authentication
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret123")
  end

  def test_invalid_authentication
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","wrong_password")
  end

  def test_index
    test_authentication
    get 'index', :page => 1
    assert_response :success
  end

  def test_activate_account
    test_authentication
    get 'index'
    assert_response :success
    @user = users(:aaron)  
    @user.updated
    get :activate_account, :id => users(:aaron).id
    assert_redirected_to admin_users_path
    assert_equal "Account has been activated for #{users(:aaron).name}.", flash[:notice]
    assert_redirected_to admin_users_path
  end
  


  def test_deactivate_account
    test_authentication
    get 'index'
    assert_response :success
    get :deactivate_account, {:id => users(:aaron).id}
    assert_equal "Account has been deactivated for #{users(:aaron).name}.", flash[:notice]
    assert_redirected_to admin_users_path
  end

  def test_list_users
    test_authentication
    get :index
    assert_response :success
    assert_tag :tag => 'table', :attributes => {:id => 'users_list'}
  end

  def test_search
    test_authentication
    @email = "quentin@example.com"
    get :search, {:email => @email}
    assert_response :redirect
  end

  def test_search_without_authentication
    @email = "quentin@example.com"
    get :search, {:email => @email}
    assert_response 401
  end

  def test_search_without_email
    test_authentication
    @email = ""
    session[:uri] = admin_users_path
    get :search, {:email => @email}
    assert_equal "Please enter Email Id", flash[:notice]
    assert_redirected_to session[:uri]
  end

  def test_search_with_invalid_email
    test_authentication
    @email = "wrong email"
    session[:uri] = admin_users_path
    get :search, {:email => @email}
    assert_equal "There is no user with this email id", flash[:notice]
    assert_redirected_to session[:uri]
  end

  def test_background_job
    test_authentication
    assert_equal 3,GamesUser.remove_those_who_grabbed_2days_ago_notify_those_who_shortlisted.size
    assert_equal 2,GamesUser.notified_but_not_grabbed.size
  end

  def test_rent_game
    test_authentication
    user = users(:quentin)
    get :rent_game, {:id => user.id}
    assert_equal "Game can't be issued to #{user.name}. The previous game hasn't been returned.", flash[:notice]
    assert_redirected_to admin_user_path(user)
  end
  
  def test_rent_game_with_no_user
    test_authentication
    session[:uri] = admin_users_path
    get :rent_game, {:id => nil}
    assert_equal "No user exists", flash[:notice]
    assert_redirected_to session[:uri]
  end

  def test_rent_game_without_authentication
    test_invalid_authentication
    user = users(:aaron)
    get :rent_game, {:id => user.id}
    assert_response 401
  end

  def test_return_game
    test_authentication
    user = users(:quentin)
    get :return_game, {:id => user.id}
    assert_equal "Game has been returned", flash[:notice]
    assert_redirected_to admin_user_path(user)
  end
  
  def test_return_game_with_no_user
    test_authentication
    session[:uri] = admin_users_path
    get :return_game, {:id => nil}
    assert_equal "No user exists", flash[:notice]
    assert_redirected_to session[:uri]
  end

  def test_rent_game_without_authentication
    test_invalid_authentication
    user = users(:aaron)
    get :rent_game, {:id => user.id}
    assert_response 401
  end

  def test_rent_game_if_no_grabbed_game
    test_authentication
    user = users(:user_with_no_game)
    session[:uri] = admin_user_path(user)
    get :rent_game, {:id => user.id}
    assert_equal "No grabbed game", flash[:notice]
    assert_redirected_to session[:uri]
  end

  def test_return_game_if_no_rented_game
    test_authentication
    user = users(:user_with_no_game)
    session[:original_uri] = admin_user_path(user)
    get :return_game, {:id => user.id}
    assert_equal "No rented game", flash[:notice]
  end

end