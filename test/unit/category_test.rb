require File.dirname(__FILE__) + '/../test_helper' 

class CategoryTest < ActiveSupport::TestCase
fixtures :all
   
  def test_has_many_games
    assert_instance_of Array, Category.find(2).games
  end
  
  def test_per_page
    assert Category.per_page, 10
  end
  
  
 def test_to_params
   @category = Platform.find_by_name("Xbox360")
   assert_equal "#{@category.name}",@category.to_param
 end
   
end
