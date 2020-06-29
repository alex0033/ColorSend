require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should not get index" do
    get users_url
    assert_redirected_to root_path
    follow_redirect!
    assert_not_empty flash
  end

  test "should get index" do
    login_as(@user, scope: :user)
    get users_url
    assert_response :success
  end

  test "should get show" do
    login_as(@user, scope: :user)
    get user_path(@user)
    assert_response :success
  end

  test "should not get show" do
    get user_path(@user)
    assert_redirected_to root_path
    follow_redirect!
    assert_not_empty flash
  end

end
