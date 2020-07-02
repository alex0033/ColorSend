require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "success sign in with facebook authenticate" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: @user.provider,
      uid: @user.uid,
      info: { name: @user.name, image: @user.image }
    })
    get user_facebook_omniauth_authorize_path
    assert_redirected_to user_facebook_omniauth_callback_path
    follow_redirect!
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_match @user.user_name, response.body
  end

  test "failer sign_in the standard way with invalid info" do
    get new_user_session_path
    post user_session_path, params: { user_name: @user.user_name,
                                       password: "invalid" }
    assert_template 'sessions/new'
  end

  test "success sign_in the standard way" do
    get new_user_session_path
    post user_session_path, params: { user: { user_name: @user.user_name,
                                               password: "password" } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_match @user.user_name, response.body
  end
end
