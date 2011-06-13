require File.dirname(__FILE__) + '/../test_helper'

class GamesControllerTest < ActionController::TestCase
  fixtures :all

  def setup
    @controller = GamesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_paginate
   12.times{g = Game.new(:name => "mario#{i||=1}",:image => "image.jpeg",
            :quantity=>1,:age_category => AgeCategory.first, 
            :platform => Platform.first, :category_ids => [1]); g.save; i+=1}
    get :index, :page => 1
    assert_response :success
    assert_select 'div.pagination'
  end

  def test_show_with_id
    get :show, :id => games(:mario).id
    assert_response :success	
  end

  def test_authorize
    @game = games(:mario1)
    get :shortlist, :id => @game.id
    assert !User.find_by_id(session[:id])
    assert_redirected_to '/login'
    assert session[:original_uri]
    assert_equal "/games/#{@game.id}/shortlist",session[:original_uri]
    assert_equal "You must be logged in.",flash[:notice]
  end
  
  def test_browse_ps3
    get :browse_by_platform, :platform => Platform.find_by_name("PS3")
    assert_response :redirect
  end
  
  def test_browse_xbox360
    get :browse_by_platform, :platform => Platform.find_by_name("PS3")
    assert_response :redirect
  end
  
  def test_browse_action
    get :browse_by_category, :category => Category.find_by_name("Action")
    assert_response :redirect
  end
  
  def test_browse_adventure
    get :browse_by_category, :category => Category.find_by_name("Adventure")
    assert_response :redirect
  end
  
  def test_browse_simulation
    get :browse_by_category, :category => Category.find_by_name("Simulation")
    assert_response :redirect
  end
  
  def test_browse_role_playing
    get :browse_by_category, :category => Category.find_by_name("Role Playing")
    assert_response :redirect
  end
  
  def test_browse_strategy
    get :browse_by_category, :category => Category.find_by_name("Strategy")
    assert_response :redirect
  end
  
  def test_check_grab_functionality
    @game = games(:mario6)
    @user = users(:aaron)
    session[:user_id] = @user.id
    get :grab, {:id => @game.id}
    assert_equal "#{@game.name} can't be grabbed.", flash[:notice]
    assert_redirected_to game_path(@game) 
  end

  def test_check_grab_functionality_if_other_user_has_grabbed_game
    @game = games(:mario3)
    @user = users(:aaron)
    session[:user_id] = @user.id
    get :grab, {:id => @game.id}
    assert_equal "#{@game.name} can't be grabbed.", flash[:notice]
    assert_redirected_to game_path(@game) 
  end

  def test_check_if_already_grabbed
    @game = games(:mario3)
    @user = users(:quentin)
    session[:user_id] = @user.id
    assert !@user.can_grab_game?(@game)
    get :grab_page, {:id => @game.id}
    assert_equal "You have already grabbed #{@user.grabbed_game.name}.", flash[:notice]
  end

  def test_if_user_has_rented_game
    @game = games(:mario3)
    @user = users(:aaron)
    session[:user_id] = @user.id
    assert !@user.can_grab_game?(@game)
    get :grab_page, {:id => @game.id}
    assert_equal "To get this game, you must return #{@user.rented_game.name} which has been issued to you.", flash[:notice]
  end

  def test_grab_if_not_logged_in
    @game = games(:mario3)
    @user = users(:aaron)
    get :grab, {:id => @game.id}
    assert_equal "You must be logged in.", flash[:notice]
    assert_redirected_to '/login'
  end

  def test_grab_page_if_not_logged_in
    @game = games(:mario3)
    @user = users(:aaron)
    get :grab_page, {:id => @game.id}
    assert_equal "You must be logged in.", flash[:notice]
    assert_redirected_to '/login'
  end
  
  def test_grab_page_redirect_to_game_path
    @game = games(:mario7)
    @user = users(:quentin)
    session[:user_id] = @user
    get :grab_page, {:id => @game.id}
    assert_equal "You have already grabbed #{@user.grabbed_game.name}.", flash[:notice]
    assert_redirected_to game_path(@game)
  end

  def test_check_shortlist_functionality_for_logged_in_user
    @game = games(:mario1)
    @user = users(:aaron)
    count = @user.shortlisted_games.count
    session[:user_id] = @user.id
    get :shortlist, {:id => @game.id}
    assert_equal count+1,@user.shortlisted_games.count
    assert_equal "#{@user.shortlisted_games.last.name} has been shortlisted by you.",flash[:notice]
  end

  def test_check_shortlist_functionality_for_!logged_in_user
    @game = games(:mario1)
    @user = users(:aaron)
    get :shortlist, {:id => @game.id}
    assert_redirected_to '/login' 
    assert_equal "Please login",flash[:notice]
  end

  def test_check_if_user_has_shortlisted_5_games
    @game = games(:mario1)
    @user = users(:singh)
    assert_equal 5,@user.shortlisted_games.count
    session[:user_id] = @user.id
    get :shortlist, {:id => @game.id}
    assert_equal "Sorry, you can shortlist atmost five games",flash[:notice]
  end

  def test_user_has_already_shortlisted_a_game
    @game = games(:mario3)
    @user = users(:quentin)
    session[:user_id] = @user.id
    get :shortlist, {:id => @game.id}
    assert_redirected_to "/"
    assert_equal "#{@game.name} has already been shortlisted by you",flash[:notice]
  end

  def test_remove_shortlisted_game
    @user = users(:quentin)
    game_to_delete = @user.shortlisted_games.first
    session[:user_id] = @user.id
    get :remove_shortlisted_game,{:id => game_to_delete.id}
    assert_redirected_to dashboard_users_path
    assert_equal "You have successfully removed #{game_to_delete.name} from your shortlisted games list.",flash[:notice]
  end

  def test_routes
    #FIX- add a routing test for root path
    assert_routing("/games/1",{:controller => "games",:action => "show",:id => "1"})
    assert_routing("/games/new",{:controller => "games",:action => "new"})
    assert_routing("/games/1/edit",{:controller => "games",:action => "edit",:id => "1"})
    assert_routing("/games",{:controller => "games",:action => "index"})		
    assert_routing("/games/1/shortlist",{:action => "shortlist",:id=> "1",:controller => "games"})
    assert_recognizes({:controller => "games",:action => "create"},{:path => "games",:method => :post})	
    assert_recognizes({:controller => "games",:action => "update",:id => "1"},{:path => "games/1",:method => :put})	
    assert_recognizes({:controller => "games",:action => "destroy",:id => "1"},{:path => "games/1",:method => :delete})
    assert_recognizes({:controller => "games",:action => "index"},{:path => "/"})
    assert_recognizes({:controller => "games",:action => "browse_by_platform",:platform => "Xbox360"},{:path => 'games/platform/Xbox360',:method => :get})
    assert_recognizes({:controller => "games",:action => "browse_by_platform",:platform => "PS3"},{:path => 'games/platform/PS3',:method => :get})
    assert_recognizes({:controller => "games",:action => "browse_by_category",:category => "Action"},{:path => 'games/category/Action',:method => :get})
    assert_recognizes({:controller => "games",:action => "browse_by_category",:category => "Adventure"},{:path => 'games/category/Adventure',:method => :get})
    assert_recognizes({:controller => "games",:action => "browse_by_category",:category => "Role Playing"},{:path => 'games/category/Role Playing',:method => :get})
    assert_recognizes({:controller => "games",:action => "browse_by_category",:category => "Simulation"},{:path => 'games/category/Simulation',:method => :get})
    assert_recognizes({:controller => "games",:action => "browse_by_category",:category => "Strategy"},{:path => 'games/category/Strategy',:method => :get})
  end

end