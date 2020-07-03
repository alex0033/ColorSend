class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications
  end

  def all_destroy
    notifications = Notification.where(visited: current_user)
    notifications.each { |notification| notification.destroy }
    redirect_to notifications_path
  end

end
