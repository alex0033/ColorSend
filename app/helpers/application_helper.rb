module ApplicationHelper
  def show_authenticate_alert
    flash[:danger] =
      "You are not be authenticated. Please push \"さぁ、はじめよう！！\" to login facebook."
  end
end
