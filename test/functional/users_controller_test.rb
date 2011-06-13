require File.dirname(__FILE__) + '/../test_helper'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase

  fixtures :users

  def test_should_allow_signup
    assert_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end

  def test_new
    get :new
    assert_response :success
    assert_select 'input[name *= name]'
    assert_select 'input[name *= email]'
    assert_select 'input[name *= phone]'
  end

  def test_valid_create
    create_user
    assert_response :redirect
    assert_redirected_to confirmation_path(User.last.id)
  end

  def test_should_require_email_on_signup
    assert_no_difference 'User.count' do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'User.count' do
      create_user(:password => nil)
      assert assigns(:user).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'User.count' do
      create_user(:password_confirmation => nil)
      assert assigns(:user).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'User.count' do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end

  def test_forgot_password_form
    get :forgot
    assert_response :success
    assert_select 'input[name*= email]'
  end

  def test_forgot_password_functionality
    params  = {:user => {:email => "saz@vinsol.com"}}
    post :forgot, params
    assert_redirected_to games_path
    assert_equal "Reset code has been sent to you at #{params[:user][:email]}.",flash[:notice]
  end

  def test_forgot_password_functionality_with_invalid_password
    params  = {:user => {:email => "sazaaa@vvvinsol.com"}}
    post :forgot, params
    assert_select 'input[name*= email]'
    assert_equal "There is no account associated with this email address.",flash[:error]
  end
 
  def test_reset_password_get_form
    @user = users(:aaron)
    get :reset,:reset_code => "#{@user.reset_code}" 
    assert_response  :success
    assert_select 'input[name *= password]'
    assert_select 'input[name *= password_confirmation]'
  end

  def test_reset_password_post_form
    @user = users(:aaron)
    post :reset,:reset_code => "#{@user.reset_code}",:user => {:password => "sazqwert1",:password_confirmation => "sazqwert1"}
    assert_equal "Password has been changed.", flash[:notice]
  end

  def test_forgot_password_bad
    params  = {:user => {:email => "pras@vinsol.com"}}
    post :forgot,params
    assert_template '/forgot'
    assert_equal "There is no account associated with this email address.",flash[:error]
  end

  def test_dob_validation
    u = User.create(:name => "quire", :email => 'quire@example.com', :password => 'quirequire', :password_confirmation => 'quirequire', :phone => 9292929292, :dob => Date.today+1.week)
    assert_equal "You have entered a wrong date of birth", u.errors.on(:base) 
  end

  def test_reset_password_bad_reset_code
    get :reset,:reset_code => "56cff93ca673b50e4392cc7d2f515941"
    assert_response 302
  end

  def test_reset_password_with_error_in_password_fields_blank
    @user = users(:aaron)
    post :reset,:reset_code => "#{@user.reset_code}",:user => {:password => "",:password_confirmation => ""}
    assert_template '/reset'
  end

  def test_reset_password_with_error_in_password_fields_too_short
    @user = users(:aaron)
    post :reset,:reset_code => "#{@user.reset_code}",:user => {:password => "saz",:password_confirmation => "saz"}
    assert_template '/reset'
  end 
  
  def test_personal_details_when_user_is_not_logged_in
   get :personal_details, :id => users(:aaron).id
   assert_redirected_to '/login'
 end

  def test_reset_password_with_error_in_password_fields_password_not_confirmed
    @user = users(:aaron)
    post :reset,:reset_code => "#{@user.reset_code}", :user => {:password => "sazetfgerger",:password_confirmation => "sazertrewtr"}
    assert_template '/reset'
 end
 
  def test_logged_in_user_should_not_able_to_call_forgot_password
   @user = users(:aaron)
   session[:user_id] = @user.id
   get 'forgot'
   assert_redirected_to games_path
  end
 
  def test_logged_in_user_should_not_able_to_go_on_reset_password_page
    @user = users(:aaron)
     session[:user_id] = @user.id
     str  = "546324jhhdfg"
     get :reset,:reset_code => "#{str}"
     assert_redirected_to games_path
  end

  def test_dashboard
    session[:user_id] = users(:aaron)
    get :dashboard, :id => users(:aaron).id
    assert_response :success
    assert_template "users/dashboard.html.erb"
  end
  
 def test_dashboard_when_user_is_not_logged_in
   get :dashboard, :id => users(:aaron).id
   assert_redirected_to '/login'
 end
 
 def test_personal_details
    session[:user_id] = users(:aaron)
    get :personal_details, :id => users(:aaron).id
    assert_response :success
    assert_template "users/personal_details.html.erb"
 end
  
 def test_personal_details_when_user_is_not_logged_in
   get :personal_details, :id => users(:aaron).id
   assert_redirected_to '/login'
 end
 
  def test_subscription_details
    session[:user_id] = users(:aaron)
    get :subs_details, :id => users(:aaron).id
    assert_response :success
    assert_template "users/subs_details.html.erb"
 end
 
 def test_subscription_details_when_user_is_not_logged_in
   get :subs_details, :id => users(:aaron).id
   assert_redirected_to '/login'
 end
 
  def test_new_password
    session[:user_id] = users(:aaron)
    get :new_password, :id => session[:user_id]
    assert_response :success
    assert_template "users/new_password.html.erb"
  end
  
  def test_new_password_if_no_current_user
    session[:user_id] = nil
    get :new_password, :id => session[:user_id]
    assert_redirected_to '/login'
    assert_equal "You must be logged in.", flash[:notice]
  end
  
  def test_change_password
    session[:user_id] = users(:saz)
    put :change_password, :old_password => "qazwsxed", :user => {:password => "qqqqqqqqqq", :password_confirmation => "qqqqqqqqqq"}
    assert_equal "Password changed successfully.", flash[:notice]
    assert_redirected_to personal_details_user_path(session[:user_id])
  end
  
  def test_change_password_if_no_old_password
    session[:user_id] = users(:saz)
    put :change_password, :old_password => nil, :user => {:password => "aaaaaaaa", :password_confirmation => "aaaaaaaa"}
    assert_equal "Please enter your current password", flash[:notice]
    assert_redirected_to new_password_user_path(session[:user_id])
  end
  
  def test_change_password_if_wrong_old_password
    session[:user_id] = users(:saz)
    put :change_password, :old_password => "wrong_password", :user => {:password => "aaaaaaaa", :password_confirmation => "aaaaaaaa"}
    assert_equal "You have entered wrong password.", flash[:notice]
    assert_redirected_to new_password_user_path(session[:user_id])
  end
  
  def test_change_password_if_no_password_and_confirmation
    session[:user_id] = users(:saz)
    put :change_password, :old_password => "qazwsxed", :user => {:password => nil, :password_confirmation => nil}
    assert_equal "can't be blank", assigns(:user).errors.on(:password)
    assert_equal "can't be blank", assigns(:user).errors.on(:password_confirmation)
  end
  
  def test_change_password_if_password_and_confirmation_dont_match
    session[:user_id] = users(:saz)
    put :change_password, :old_password => "qazwsxed", :user => {:password => "abcdefgh", :password_confirmation => "hgfedcba"}
    assert_equal "doesn't match confirmation", assigns(:user).errors.on(:password)
  end
  
  def test_personal_details_when_user_is_not_logged_in
    get :personal_details, :id => users(:aaron).id
    assert_redirected_to '/login'
  end

  protected
  
  def create_user(options = {})
    post :create, :user => {:name => "quire", :email => 'quire@example.com', :password => 'quirequire', :password_confirmation => 'quirequire', :phone => 9292929292, :dob => Date.today}.merge(options)
  end
  
end
