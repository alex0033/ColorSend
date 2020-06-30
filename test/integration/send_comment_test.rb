require 'test_helper'

class SendCommentTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @micropost = set_micropost(@user)
    login_as(@user)
  end

  test "failer because of blank" do
    post comments_path, params: { comment: { content: "  " },
                             micropost_id: @micropost.id }
    comment = assigns(:comment)
    assert_not_empty comment.errors
  end

  test "succsess" do
    content = "I am happy."
    post comments_path, params: { comment: { content: content },
                             micropost_id: @micropost.id }
    assert_redirected_to @micropost
    follow_redirect!
    assert_template 'microposts/show'
    assert_match content, response.body
  end

end
