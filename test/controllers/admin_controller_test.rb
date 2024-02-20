require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get member" do
    get admin_member_url
    assert_response :success
  end
end
