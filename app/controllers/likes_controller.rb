class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    micropost = Micropost.find(params[:micropost_id])
    @like = current_user.likes.create!(micropost: micropost)
    current_user.create_like_notification(micropost)
    # この先を前回のURLにする？
    redirect_to micropost_path(micropost)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    # この先を前回のURLにする？
    redirect_to like.micropost
  end

end
