require "test_helper"

class NotifivationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notifivations_index_url
    assert_response :success
  end
end
