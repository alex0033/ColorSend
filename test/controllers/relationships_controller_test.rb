require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "not signed in user should not follow" do
    post relationships_path, params: { followed_id: 1 }
    assert_redirected_to root_path
    assert_not_empty flash
  end

  test "not signed in user should not unfollow" do
    post relationships_path, params: { id: 1 }
    assert_redirected_to root_path
    assert_not_empty flash
  end

end
