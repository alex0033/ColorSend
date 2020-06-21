require 'test_helper'
include Warden::Test::Helpers

class FacebookAuthenticateTest < ActionDispatch::IntegrationTest

  def setup
    @new_user   = User.new(name: "foobar", user_name: "foo",
                     password: "foobar", password_confirmation: "foobar")
    @saved_user = users(:one)

    OmniAuth.config.test_mode = true
  end

  def setMock_auth_for_new_user
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => "facebook",
      :uid => "1111111",
      :info =>  { :name => @new_user.name, :image => "https://localhost:3000" }
    })
  end

  def setMock_auth_for_saved_user
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => @saved_user.provider,
      :uid => @saved_user.uid,
      :info =>  { :name => @saved_user.name, :image => "https://localhost:3000" }
    })
  end

  test "sign up" do
    setMock_auth_for_new_user

    # 無効なサインアップページアクセス
    get new_user_registration_path
    assert_redirected_to root_url
    assert_not flash.empty?

    # 有効なサインアップページアクセス
    get user_facebook_omniauth_authorize_path

    # 無効なサインアップ
    assert_redirected_to user_facebook_omniauth_callback_path
    follow_redirect!
    assert_redirected_to new_user_registration_path
    follow_redirect!
    assert_template 'devise/registrations/new'
    assert_match @new_user.name, response.body
    post user_registration_path, params: { user: { name: @new_user.name,
                                              user_name: "",
                                               password: @new_user.password,
                                  password_confirmation: @new_user.password_confirmation } }
    user = assigns(:user)
    assert_template 'devise/registrations/new'
    assert_match @new_user.name, response.body
    assert_not_empty user.errors

    #有効なサインアップ
    post user_registration_path, params: { user: { name: @new_user.name,
                                              user_name: @new_user.user_name,
                                               password: @new_user.password,
                                  password_confirmation: @new_user.password_confirmation } }
    user = assigns(:user)
    assert_redirected_to user_url(user)
    follow_redirect!
    assert_template 'users/show'
  end


  test "sign in" do
    setMock_auth_for_saved_user

    login_as(@saved_user, scope: :user)
    get user_facebook_omniauth_authorize_path
    assert_redirected_to user_facebook_omniauth_callback_path
    follow_redirect!
    assert_redirected_to user_url(@saved_user)
    follow_redirect!
    assert_template 'users/show'
    assert_match @saved_user.user_name, response.body
  end

end
