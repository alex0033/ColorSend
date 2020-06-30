require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    login_as(@user)
    @micropost = set_micropost(@user)
  end

  test "can search" do
    get search_path, params: { search: "title" }
    microposts = assigns(:microposts)
    assert_equal microposts.first.title, "title"
  end

  test "cannot search" do
    get search_path, params: { search: "cannot find" }
    assert_match "検索結果は何もありません", response.body
  end

end
