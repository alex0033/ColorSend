require 'test_helper'
include Warden::Test::Helpers

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_redirected_to ~~
    login_as(@user, scope: :user)
    get users_url
    assert_response :success
  end

  test "should get show" do
    get user_url(@user)
    assert_redirected_to ~~ 
    login_as(@user, scope: :user)
    get user_url(@user)
    assert_response :success
  end

end
