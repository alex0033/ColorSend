require 'test_helper'
include Warden::Test::Helpers

class PasswordEditTest < ActionDispatch::IntegrationTest

  test "password edit" do
    # make user
    current_password = "password"
    new_password     = "foobar"
    @user = users(:one)

    login_as(@user, scope: :user)
    assert @user.valid_password?(current_password)
    assert_not @user.valid_password?(new_password)
    get passwords_edit_path

    # failer with wrong current_password
    patch passwords_update_path , params: { user: { current_password: "wrongpass",
                                                         password: new_password,
                                            password_confirmation: new_password } }
    assert_template 'passwords/edit'
    user = assigns(:user)
    assert user.errors.empty?
    assert_not flash.empty?

    #failer with invalid password
    patch passwords_update_path , params: { user: { current_password: current_password,
                                                         password: new_password,
                                            password_confirmation: "foobaz" } }
    assert_template 'passwords/edit'
    user = assigns(:user)
    assert_not user.errors.empty?
    assert flash.empty?

    #failer with wrong current_password and invalid password
    patch passwords_update_path , params: { user: { current_password: "wrongpass",
                                                         password: new_password,
                                            password_confirmation: "foobaz" } }
    assert_template 'passwords/edit'
    user = assigns(:user)
    assert_not user.errors.empty?
    assert_not flash.empty?

    # success
    patch passwords_update_path , params: { user: { current_password: current_password,
                                                         password: new_password,
                                            password_confirmation: new_password } }
    user = assigns(:user)
    assert user.errors.empty?
    assert_not flash.empty?
    assert_redirected_to user_url(user)
    follow_redirect!
    assert_template 'users/show'
    user = assigns(:user)
    assert_not user.reload.valid_password?(current_password)
    assert user.valid_password?(new_password)
  end
end
