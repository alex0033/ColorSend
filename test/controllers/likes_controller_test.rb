require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user      = users(:one)
    @micropost = set_micropost(@user)
    @like      = set_like(@user, @micropost)
  end

  test "not signed in user should not create" do
    post likes_path, params: { micropost_id: @micropost.id }
    assert_redirected_to root_path
    follow_redirect!
    assert_not_empty flash
  end

  test "not signed in user sholud not delete" do
    assert_difference 'Like.count', 0 do
      delete like_path(@like)
    end
  end

  test "wrong user sholud not delete" do
    login_as(users(:two))
    assert_difference 'Like.count', 0 do
      delete like_path(@like)
    end
  end

  test "correct user can delete" do
    login_as(@user)
    assert_difference 'Like.count', -1 do
      delete like_path(@like)
    end
  end
end
