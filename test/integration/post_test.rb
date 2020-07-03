require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  test "post" do
    # oneとしてログイン
    user = users(:one)
    login_as(user)
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
  end
end
