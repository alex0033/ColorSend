require 'test_helper'


class FacebookAuthenticateTest < ActionDispatch::IntegrationTest

  test "delete account" do
    user = users(:one)
    login_as(user, scope: :user)
    get user_path(user)
    assert_select 'a[href=?]', edit_user_registration_path
    get edit_user_registration_path
    assert_select 'a[href=?]', user_registration_path, method: :delete
    delete user_registration_path
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_not User.all.include?(user)
  end


end
