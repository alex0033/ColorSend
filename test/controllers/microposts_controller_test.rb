require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user      = users(:one)
    @micropost = microposts(:one)
  end

  test "should not get new" do
    get new_micropost_path
    assert_redirected_to root_path
    follow_redirect!
    assert_match error_message, response.body
  end

  test "should get new" do
    login_as(@user, scope: :user)
    get new_micropost_path
    assert_response :success
  end

  test "should not get new" do
    get micropost_path(@micropost)
    assert_redirected_to root_path
    follow_redirect!
    assert_match error_message, response.body
  end

  test "should get show" do
    login_as(@user, scope: :user)
    get micropost_path(@micropost)
    assert_response :success
  end

  test "not signed in user sholud not delete" do
    assert_difference 'Micropost.count', 0 do
      delete micropost_path(@micropost)
    end
  end

  test "wrong user sholud not delete" do
    login_as(@two, scope: :user)
    assert_difference 'Micropost.count', 0 do
      delete micropost_path(@micropost)
    end
  end

  test "correct user can delete" do
    login_as(@one, scope: :user)
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(@micropost)
    end
  end

end
