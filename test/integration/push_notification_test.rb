require 'test_helper'

class PushNotificationTest < ActionDispatch::IntegrationTest

  def setup
    @visiter = users(:one)
    @visited = users(:two)
    login_as(@visited, scope: :user)
    @micropost = set_micropost(@visited)
    logout(:user)
    login_as(@visiter, scope: :user)
  end


  test "confirm comment notification" do
    # コメントをする
    content = "I am happy."
    post comments_path, params: { comment: { content: content },
                             micropost_id: @micropost.id }
    logout(:user)

    # 通知の確認
    login_as(@visited, scope: :user)
    get notifications_path
    user_name = @visiter.user_name
    message = "\"#{user_name}\"があなたの投稿にコメントしました。"
    assert_match CGI.escapeHTML(message), response.body
    assert_not assigns(:notifications).first.checked?
    logout(:user)
  end


  test "confirm like notification" do
    # コメントをする
    post likes_path, params: { micropost_id: @micropost.id }
    logout(:user)

    # 通知の確認
    login_as(@visited, scope: :user)
    get notifications_path
    user_name = @visiter.user_name
    message = "\"#{user_name}\"があなたの投稿にいいねしました。"
    assert_match CGI.escapeHTML(message), response.body
    assert_not assigns(:notifications).first.checked?
    logout(:user)
  end

end
