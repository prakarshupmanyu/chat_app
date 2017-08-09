require 'test_helper'

class ChatappControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get chatapp_login_url
    assert_response :success
  end

  test "should get register" do
    get chatapp_register_url
    assert_response :success
  end

end
