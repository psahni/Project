require File.dirname(__FILE__) + '/../test_helper'

class StaticControllerTest < ActionController::TestCase
  fixtures :users
  
  def test_confirmation_page
    get :confirmation, {:id => users(:quentin).id}
    assert_response :success 
    assert_template 'confirmation'
  end
  
end
