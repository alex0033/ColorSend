require 'test_helper'
include Warden::Test::Helpers

class LayoutsTest < ActionDispatch::IntegrationTest
  def setup
    @followering_user = users(:one)
    @followed_user    = users(:two)
  end

  test "layouts test" do
    get root_path
    assert_select 'a[href=?]', user_facebook_omniauth_authorize_path,
                                              method: :post, count: 2

    login_as(@following_user, scope: :user)
    get  root_path
    # tuuti
    # serchbox
    assert_select 'a[href=?]', user_path(@following_user)
    assert_select 'a[href=?]', user_registration_path, method: :delete
    # 通じるか分からない
    # assert_match @followed_user.image, response.body


  end
end
