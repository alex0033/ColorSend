require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user      = users(:one)
    @micropost = set_micropost(@user)
    @comment   = set_comment(@user, @micropost)
    @params    = { micropost_id: @micropost.id,
                            comment: { content: "I am happy" } }
  end

  test "not signed in user should not create" do
    post comments_path, params: @params
    assert_redirected_to root_path
    follow_redirect!
    assert_not_empty flash
  end

  test "not signed in user sholud not delete" do
    assert_difference 'Comment.count', 0 do
      delete comment_path(@comment)
    end
  end

  test "wrong user sholud not delete" do
    login_as(users(:two))
    assert_difference 'Comment.count', 0 do
      delete comment_path(@comment)
    end
  end

  test "correct user can delete" do
    login_as(@user)
    assert_difference 'Comment.count', -1 do
      delete comment_path(@comment)
    end
  end
end
