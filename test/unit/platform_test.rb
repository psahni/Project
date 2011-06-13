require File.dirname(__FILE__) + '/../test_helper' 

class PlatformTest < ActiveSupport::TestCase
  fixtures :all
  def test_has_many_games
    assert_instance_of Array, Platform.find(2).games
  end
  
  def test_per_page
    assert_equal Platform.per_page, 10
  end
  
 def test_to_params
   @platform = Platform.find_by_name("Xbox360")
   assert_equal "#{@platform.name}",@platform.to_param
 end
  
end
