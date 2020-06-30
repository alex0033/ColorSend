require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(name: "foobar", user_name: "foo",
                     password: "foobar", password_confirmation: "foobar")
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => "facebook",
      :uid => "1111111",
      :info =>  { :name => @user.name, :image => "https://localhost:3000" }
    })
  end

  def facebook_authenticte
    get user_facebook_omniauth_authorize_path
    assert_redirected_to user_facebook_omniauth_callback_path
    follow_redirect!
    assert_redirected_to new_user_registration_path
    follow_redirect!
    assert_template 'devise/registrations/new'
    assert_match @user.name, response.body

  end

  test "invalid accsess to signup path" do
    # 無効なサインアップページアクセス
    get new_user_registration_path
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end

  test "failer with invalid info" do
    facebook_authenticte
    post user_registration_path, params: { user: { name: @user.name,
                                              user_name: "",
                                               password: @user.password,
                                  password_confirmation: @user.password_confirmation,
                                            user_policy: "1" } }
    user = assigns(:user)
    assert_template 'devise/registrations/new'
    assert_match @user.name, response.body
    assert_not_empty user.errors
  end

  test "failer without reading user_policy" do
    facebook_authenticte
    post user_registration_path, params: { user: { name: @user.name,
                                              user_name: @user.user_name,
                                               password: @user.password,
                                  password_confirmation: @user.password_confirmation,
                                            user_policy: "0" } }
    user = assigns(:user)
    assert_template 'devise/registrations/new'
    assert_match @user.name, response.body
    assert_not_empty user.errors
  end

  test "success" do
    facebook_authenticte
    post user_registration_path, params: { user: { name: @user.name,
                                              user_name: @user.user_name,
                                               password: @user.password,
                                  password_confirmation: @user.password_confirmation,
                                            user_policy: "1" } }
    user = assigns(:user)
    assert_redirected_to user
    follow_redirect!
    assert_template 'users/show'

  end
end
