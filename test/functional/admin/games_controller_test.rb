require File.dirname(__FILE__) + '/../../test_helper'

class Admin::GamesControllerTest < ActionController::TestCase
  fixtures :all
  
  def test_authentication
		@request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","secret123")
	end
	
	def test_invalid_authentication
		@request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin","wrong_password")
	end
  
  def session_original_uri
    @game = games(:mario)
    session[:uri] = "admin/games/#{@game.id}"
  end
  
  def test_new_invalid
    test_invalid_authentication
    get :new
    assert_response 401
  end
  
  def test_create_invalid
    test_invalid_authentication
    params = {:game =>{:name => "test", :description => "test", :quantity => 1, :age_category_id => AgeCategory.first, :platform_id => Platform.first, :category_id => Category.first, :image_file_name => "images.jpeg", :image_content_type => "image/jpeg", :image_file_size => "200" }}
		post :create, params
		assert_response 401
  end
  
  def test_edit_invalid
    test_invalid_authentication
    get :edit
    assert_response 401
  end
  
  def test_update_invalid
    test_invalid_authentication
    put :update, :id => games(:test1).id, :game => {:name => "crazy four"}
    assert_response 401
  end
  
  def test_destroy
    test_invalid_authentication
    delete :destroy, :id => games(:prince).id
    assert_response 401
  end

	def test_paginate
	  test_authentication
	  Game.delete_all
	  35.times {|i| Game.create(:name => "name#{i}", :quantity => 1, :description => "test", :age_category_id => 1, :platform_id => 1, :category_ids => [2], :image_file_name => "images.gif", :image_content_type => "image/gif", :image_file_size => "200")}
	  get :index, :page => 1
	  assert_response :success
	  assert_select 'div.pagination'
	end
  
	def test_show_with_id
    test_authentication 
		get :show, :id => games(:mario).id
		assert_response :success	
	end

	def test_new_page
	  test_authentication
		get	:new
		assert_response :success
		assert_select 'form.new_game'
	end

	def test_create
	  test_authentication
		game_hash = {:name => "test", :description => "test", :age_category => AgeCategory.first, :platform => Platform.first, :category_ids => [1], :image_file_name => "images.jpeg", :image_content_type => "image/jpeg", :image_file_size => "200",:quantity => 2 }
    assert_difference('Game.count') do
      post :create, :game => game_hash
    end
		assert_redirected_to admin_game_path(Game.last)
		assert_equal "Game has been created successfully", flash[:notice]	
	end

	def test_invalid_create
	    test_authentication
			params = {:game => {:name =>""}}			
			post	:create,params
			assert_equal false, Game.new(params[:game]).valid?
			assert_template  "games/new"
	end

	
	def test_edit_page
	  test_authentication
		get	:edit, :id => games(:mario).id
		assert_response :success 
		assert_template 'edit'
		assert_select 'form.edit_game'
		assert session[:uri]!=nil
	end
	
	def show
	  test_authentication
	  get :show, :id => games(:mario).id
	  assert_template 'show'
    assert session[:original_uri]!=nil
  end
	
	def test_remove_image
	  session_original_uri
    test_authentication
		get	:remove_image, :id => @game.id   
		@game.reload
    assert_equal nil, @game.image_file_name 
    assert_equal "Image has been removed", flash[:notice] 
    assert_redirected_to admin_game_path(@game.id)
  end

	def test_update
	  test_authentication
		put :update, :id => games(:test1).id, :game => {}		
		assert_redirected_to admin_game_path(assigns(:game))
		assert_equal "Game has been updated successfully", flash[:notice]
	end

	def test_destroy
	  test_authentication
		delete :destroy, :id => games(:prince).id
		assert_equal "Game has been deleted successfully", flash[:notice]
		assert_redirected_to	admin_games_path		
	end

	def test_routes
	  #FIX- add a routing test for root path
		assert_routing("/admin/games/1",{:controller => "admin/games",:action => "show",:id => "1"})
		assert_routing("/admin/games/new",{:controller => "admin/games",:action => "new"})
		assert_routing("/admin/games/1/edit",{:controller => "admin/games",:action => "edit",:id => "1"})
		assert_routing("/admin",{:controller => "admin/games",:action => "index"})		
		assert_recognizes({:controller => "admin/games",:action => "create"},{:path => "admin/games",:method => :post})	
		assert_recognizes({:controller => "admin/games",:action => "update",:id => "1"},{:path => "admin/games/1",:method => :put})	
		assert_recognizes({:controller => "admin/games",:action => "destroy",:id => "1"},{:path => "admin/games/1",:method => :delete})
	end
end
