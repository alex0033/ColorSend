require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest

  test "not signed in user sholud not get index" do
    get notifications_path
    assert_redirected_to root_path
    assert_not_empty flash
  end

  test "not signed in user sholud not delete" do
    assert_difference 'Notification.count', 0 do
      delete all_destroy_notifications_path
    end
  end

end
