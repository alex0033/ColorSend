require 'test_helper'


class FacebookAuthenticateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => @user.provider,
      :uid => @user.uid,
      :info =>  { :name => @user.name, :image => "https://localhost:3000" }
    })
  end

  test "delete account" do
    # アカウント削除
    login_as(@user, scope: :user)
    get root_path
    assert_select 'a[href=?]', edit_user_registration_path
    get edit_user_registration_path
    assert_select 'a[href=?]', user_registration_path
    delete user_registration_path
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_not User.all.include?(@user)
  end

  # test "sign in and sign out" do
  #   login_as(user, scope: :user)
  #   get user_facebook_omniauth_authorize_path
  #   assert_redirected_to user_facebook_omniauth_callback_path
  #   follow_redirect!
  #   assert_redirected_to @user
  #   follow_redirect!
  #   assert_template 'users/show'
  #   assert_match @user.user_name, response.body
  #   # assert is_logged_in?
  #
  #   # logout
  #   # assert_select "a[herf=?]", destroy_user_session_path
  #   delete destroy_user_session_path
  #   assert_redirected_to root_path
  #   follow_redirect!
  #   assert_not flash.empty?
  # end

end
