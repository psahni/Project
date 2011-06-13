require File.dirname(__FILE__) + '/../test_helper' 

class AgeCategoryTest < ActiveSupport::TestCase
  fixtures :all
   
   def test_has_many_games
    assert_instance_of Array, AgeCategory.first.games
   end
end
