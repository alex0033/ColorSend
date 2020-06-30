require 'test_helper'

class PushNotificationTest < ActionDispatch::IntegrationTest

  def setup
    @visiter = users(:one)
    @visited = users(:two)
    @micropost = set_micropost(@visited)
    login_as(@visiter)
  end


  test "confirm comment notification" do
    # コメントをする
    content = "I am happy."
    assert_difference 'Notification.count', 1 do
      post comments_path, params: { comment: { content: content },
                               micropost_id: @micropost.id }
    end
    logout

    # 通知の確認
    login_as(@visited)
    get notifications_path
    user_name = @visiter.user_name
    message = "\"#{user_name}\"があなたの投稿にコメントしました。"
    assert_match CGI.escapeHTML(message), response.body
    logout(:user)
  end


  test "confirm like notification" do
    # コメントをする
    assert_difference 'Notification.count', 1 do
      post likes_path, params: { micropost_id: @micropost.id }
    end
    logout

    # 通知の確認
    login_as(@visited)
    get notifications_path
    user_name = @visiter.user_name
    message = "\"#{user_name}\"があなたの投稿にいいねしました。"
    assert_match CGI.escapeHTML(message), response.body
    logout
  end

end
