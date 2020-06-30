require 'test_helper'

class SignInTest < ActionDispatch::IntegrationTest

  test "success sign in" do
    @user = users(:one)
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
end
