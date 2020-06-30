require 'test_helper'

class PressLikeButtonTest < ActionDispatch::IntegrationTest

  def setup_for_create
    @micropost = set_micropost(users(:one))
    login_as(users(:two))
  end

  def setup_for_destroy
    one = users(:one)
    two = users(:two)
    @micropost = set_micropost(one)
    @like      = set_like(two, @micropost)
    login_as(two)
  end

  test "create like the standard way" do
    setup_for_create
    assert_difference 'Like.count', 1 do
      post likes_path, params: { micropost_id: @micropost.id }
    end
    assert_redirected_to @micropost
    follow_redirect!
  end

  test "create like with Ajax" do
    setup_for_create
    assert_difference 'Like.count', 1 do
      post likes_path, params: { micropost_id: @micropost.id }, xhr: true
    end
  end

  test "destroy like the standard way" do
    setup_for_destroy
    assert_difference 'Like.count', -1 do
      delete like_path(@like)
    end
    assert_redirected_to @micropost
    follow_redirect!
  end

  test "destroy like with Ajax" do
    setup_for_destroy
    assert_difference 'Like.count', -1 do
      delete like_path(@like), xhr: true
    end
  end
end
