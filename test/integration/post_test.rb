require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  test "post, comment, and fabo" do
    # oneとしてログイン
    user = users(:one)
    login_as(user, scope: :user)
    get new_micropost_path

    # 画像投稿失敗
    invalid_image = fixture_file_upload('test/fixtures/OverSize.jpg', 'image/jpeg')
    post microposts_path, params: { micropost: { image: invalid_image } }
    micropost = assigns(:micropost)
    assert_not_empty micropost.errors

    # 画像投稿成功
    valid_image = fixture_file_upload('test/fixtures/test.png', 'image/png')
    post microposts_path, params: { micropost: { title: "title", image: valid_image } }
    micropost = assigns(:micropost)
    assert_redirected_to micropost
    follow_redirect!
    assert_template 'microposts/show'

    # ログアウトする
    logout(:user)

    # twoとしてログイン
    user = users(:two)
    login_as(user, scope: :user)

    # 間にリンクがない
    get micropost_path(micropost)

    # コメント投稿失敗
    post comments_path, params: { comment: { content: "  " },
                             micropost_id: micropost.id }
    # ココにフラシュかなんかが必要
    # フロントエンドによるlayoutの変化？？

    # コメント成功
    content = "I am happy."
    post comments_path, params: { comment: { content: content },
                             micropost_id: micropost.id }

    # ココで通知されるtest書こう！！

    assert_redirected_to micropost
    follow_redirect!
    assert_template 'microposts/show'
    assert_match content, response.body

  end
end
