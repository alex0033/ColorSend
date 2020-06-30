require 'test_helper'

class SignOutTest < ActionDispatch::IntegrationTest
  test "sign out" do
    user = users(:one)
    login_as(user, scope: user) 
    delete destroy_user_session_path
    assert_redirected_to root_path
    follow_redirect!

    #ログインしていないことの確認
    get users_path
    assert_redirected_to root_path
  end
end
