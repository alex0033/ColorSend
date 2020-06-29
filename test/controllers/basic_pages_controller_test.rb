require 'test_helper'

class BasicPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "not signed in user should not get search" do
    get search_path
    assert_redirected_to root_path
  end

end
