require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def assert_match_unless_nil(data_name)
    if object = @user.send(data_name)
      assert_match object.to_s, response.body
    end
  end

  test "user edit" do
    @user = users(:one)
    login_as(@user, scope: :user)
    get edit_user_registration_path
    assert_match @user.name,              response.body
    assert_match @user.user_name,         response.body
    assert_match_unless_nil "self_introduction"
    assert_match_unless_nil "website"
    assert_match_unless_nil "phone_number"
    assert_match_unless_nil "email"
    assert_match_unless_nil "gender"

    # fail edit
    patch user_registration_path, params: { user: {name: @user.name,
                                              user_name: "",
                                      self_introduction: @user.self_introduction,
                                                website: @user.website,
                                                  email: @user.email,
                                                 gender: @user.gender } }
    user = assigns(:user)
    assert_not user.errors.empty?

    # success edit
    patch user_registration_path, params: { user: {name: @user.name,
                                              user_name: "success_user",
                                      self_introduction: @user.self_introduction,
                                                website: @user.website,
                                                  email: @user.email,
                                                 gender: @user.gender } }
    user = assigns(:user)
    assert_equal "success_user", user.user_name
    assert user.errors.empty?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end

end
