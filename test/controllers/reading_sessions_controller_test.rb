require "test_helper"

class ReadingSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reading_sessions_create_url
    assert_response :success
  end

  test "should get update" do
    get reading_sessions_update_url
    assert_response :success
  end
end
