class BasicPagesController < ApplicationController
  before_action :authenticate_user!, only: [:search]

  def home
    if user_signed_in?
      @microposts = current_user.feed
    end
    render :layout => "second_layout"
  end

  def search
    @microposts = Micropost.search(params[:search]).paginate(page: params[:page])
  end

end
