class NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications
  end

  # 該当するuserの通知を全て削除する
  def all_destroy
    notifications = Notification.where(visited: current_user)
    notifications.each { |notification| notification.destroy }
    redirect_to notifications_path
  end

end
