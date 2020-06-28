class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @current_micropost = Micropost.find(params[:micropost_id])
    @like = current_user.likes.create!(micropost: @current_micropost)
    current_user.create_like_notification(@current_micropost)
    respond_to do |format|
      format.html { redirect_to micropost }
      format.js
    end

  end

  def destroy
    like = Like.find(params[:id])
    @current_micropost = like.micropost
    like.destroy
    respond_to do |format|
      format.html { redirect_to current_micropost }
      format.js
    end
  end

end
