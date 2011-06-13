require File.dirname(__FILE__) + '/../test_helper'

class GameTest < ActiveSupport::TestCase
  fixtures :all
  
  def test_presence
    game = Game.new
    assert !game.valid?
    assert game.errors.invalid?(:name)
    assert game.errors.invalid?(:age_category_id)
    assert game.errors.invalid?(:platform_id)
    assert game.errors.invalid?(:quantity)
  end
  
  def test_per_page
    assert Game.per_page, 10
  end
  
  def test_uniqueness  
    g = Game.new(:name => "mario", :description => "test", :age_category_id => 1, :platform_id => 1)
    assert !g.save
    assert_equal "has already been taken", g.errors.on(:name)
  end
  
  def test_uniqueness_case_insensitive
    g = Game.new(:name => "Mario", :description => "test", :age_category_id => 1, :platform_id => 2)
    assert !g.save
    assert_equal "has already been taken", g.errors.on(:name)
  end
  
  def test_numericality
    g = Game.new(:name => "mario", :description => "test", :age_category_id => 1, :platform_id => 2, :quantity => 's')
    assert !g.save
    assert_equal "is not a number", g.errors.on(:quantity)  
  end
  
  def test_negative_quantity
    g = Game.new(:name => "mario", :description => "test", :age_category_id => 1, :platform_id => 2, :quantity => -1)
    assert !g.save
    assert_equal "must be greater than or equal to 0", g.errors.on(:quantity)  
  end
  
  def test_file_size
    g = Game.new(:name => "test", :description => "test", :age_category_id => 1, :platform_id => 2, :image_file_size => 20000000)
    assert !g.errors.invalid?(:image_file_size)
  end
  
  def test_paperclip
    g = Game.new(:name => "test", :description => "test",:age_category_id => 1, :platform_id => 2, :image_file_size => 20000000, :image_file_name => "test.gif", :image_content_type => "/image/gif")
    assert g.image
  end
	
  def test_attachment
    g = Game.new
    assert g.respond_to?(:save_attached_files)
  end
	  
  def test_inclusion_of
    g = Game.new(:name => "test", :description => "test",:quantity => 0 ,:age_category_id => 5, :platform_id => 7, :image => "image.jpeg")
    g.save 
    assert_equal "is not included in the list", g.errors.on(:platform)
    assert_equal "is not included in the list", g.errors.on(:age_category)
  end
  
  def test_not_available_for_shortlisting
    @game = games(:mario)
    assert_equal 3, @game.quantity
    assert !@game.available_for_shortlisting
  end
  
  def test_shortlisting_when_grabbed
    @game = games(:free_game)
    assert_equal 1, @game.quantity
    assert_equal 1, @game.users_who_grabbed.count
    assert_equal true, @game.available_for_shortlisting
  end
  
  def test_shortlisting_when_game_is_grabbed_and_rented
    @game = games(:free_game)
    assert_equal 1, @game.quantity
    assert_equal 1, @game.users_who_grabbed.count
    assert_equal 0, @game.users_who_rented.count  
    assert @game.available_for_shortlisting
    assert_equal 0, @game.quantity_left
    assert_equal true, @game.available_for_shortlisting
  end
  
  def test_has_many_users_who_grabbed_through_games_users
    g = games(:mario)
    before_grabbed_games = g.users_who_grabbed.size   
    g.games_users << GamesUser.create(:game => g, :user => users(:raju), :status => RENTING_STATUS[:grabbed])   
    assert_equal before_grabbed_games+1, g.users_who_grabbed.size
  end
  
  def test_has_many_users_who_rented_through_games_users
    g = games(:mario)
    before_rented_games = g.users_who_rented.size
    g.games_users << GamesUser.create(:game => g, :user => users(:raju), :status => RENTING_STATUS[:rented])
    assert_equal before_rented_games+1, g.users_who_rented.size
  end
  
  def test_has_many_users_who_rented_through_games_users
    g = games(:mario)
    before_subscribed_games = g.subscribed_users.size
    g.games_users << GamesUser.create(:game => g, :user => users(:raju), :status => RENTING_STATUS[:subscribed])
    assert_equal before_subscribed_games+1, g.subscribed_users.size
  end
  
  def test_has_many_users_who_are_notified_through_games_users
    g = games(:mario)
    before_notified_games = g.notified_users.size
    g.games_users << GamesUser.create(:game => g, :user => users(:raju), :status => RENTING_STATUS[:notified])
    assert_equal before_notified_games+1, g.notified_users.size
  end
  
  def test_has_many_users_who_shortlisted_through_games_users
    g = games(:mario)
    before_shortlisted_games = g.users_who_shortlisted.count
    g.users_who_shortlisted << GamesUser.create(:user_id => users(:raju).id, :game_id => games(:mario4).id, :status => RENTING_STATUS[:shortlisted]).user
    assert_equal before_shortlisted_games+1, g.users_who_shortlisted.count
  end
  
  def test_has_many_games_users
    g = games(:mario)
    before_games_users = g.games_users
    assert before_games_users
  end
  
  def test_has_many_users
    g = games(:mario)
    before_games_users = g.users
    assert before_games_users
  end
  
  def test_game_habtm_categories
    game = Game.first
    assert_instance_of Array, game.categories 
  end
  
  def test_game_belongs_to_category
    game = Game.first
    assert_instance_of Array, game.categories 
  end
  
  def test_game_belongs_to_platform
    game = Game.first
    assert_instance_of AgeCategory, game.age_category
  end

  def test_named_scope
    Game.delete_all
    one = Game.create(:name => "one", :description => "test", :age_category => AgeCategory.first, :platform => Platform.first, :category_ids => [2], :quantity => 1)
    two = Game.create(:name => "two", :description => "test", :age_category => AgeCategory.first, :platform => Platform.last, :category_ids => [3], :quantity => 1)
    three = Game.create(:name => "three", :description => "test", :age_category => AgeCategory.first, :platform => Platform.first, :category_ids => [1], :quantity => 1)
    four = Game.create(:name => "four", :description => "test", :age_category => AgeCategory.first, :platform => Platform.last, :category_ids => [4], :quantity => 1)
    five = Game.create(:name => "five", :description => "test", :age_category => AgeCategory.first, :platform => Platform.first, :category_ids => [5], :quantity => 1)
    assert_equal([one, three, five], Game.ps3)
    assert_equal([two, four], Game.xbox360)
    assert_equal([one], Category.find_by_name('Action').games)
    assert_equal([two], Category.find_by_name('Adventure').games)
    assert_equal([three], Category.find_by_name('Simulation').games)
    assert_equal([four], Category.find_by_name('Role Playing').games)
    assert_equal([five], Category.find_by_name('Strategy').games)
  end
  
  def test_show_all_games
    @games = Game.all
    games  = Game.show_all_games
    assert_equal games,@games
  end

  def test_categories
   @game = Game.first
   assert_instance_of Array,@game.find_categories
 end
 
 def test_to_params
   @game = Game.first
   assert_equal "#{@game.id}-#{@game.name}",@game.to_param
 end
end