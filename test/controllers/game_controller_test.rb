require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get game_home_url
    assert_response :see_other
  end
end
