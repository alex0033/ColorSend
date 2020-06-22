class BasicPagesController < ApplicationController
  def home
    if user_signed_in?
      @microposts = current_user.feed
    end
    render :layout => "second_layout"
  end
end
