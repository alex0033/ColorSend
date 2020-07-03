require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest

  def assert_match_unless_nil(data_name)
    if object = @user.send(data_name)
      assert_match object.to_s, response.body
    end
  end

  test "user edit" do
    @user = users(:one)
    login_as(@user)
    get edit_user_registration_path
    assert_match_unless_nil "name"
    assert_match_unless_nil "user_name"
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
                                           phone_number: @user.phone_number,
                                                  email: @user.email,
                                                 gender: @user.gender } }
    user = assigns(:user)
    assert_not user.errors.empty?

    edit_name              = "edit_name"
    edit_user_name         = "edit_name"
    edit_self_introduction = "edit_self_introduction"
    edit_website           = "https://edi.com"
    edit_phone_number      = "08011116666"
    edit_email             = "edit@edi.com"
    edit_gender            = "edi"

    # success edit
    patch user_registration_path, params: { user: {name: edit_name,
                                              user_name: edit_user_name,
                                      self_introduction: edit_self_introduction,
                                                website: edit_website,
                                           phone_number: edit_phone_number,
                                                  email: edit_email,
                                                 gender: edit_gender } }
    user = assigns(:user)
    assert_equal edit_name,              user.name
    assert_equal edit_user_name,         user.user_name
    assert_equal edit_self_introduction, user.self_introduction
    assert_equal edit_website,           user.website
    assert_equal edit_email,             user.email
    assert_equal edit_phone_number,      user.phone_number
    assert_equal edit_gender,            user.gender
    assert user.errors.empty?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end

end
