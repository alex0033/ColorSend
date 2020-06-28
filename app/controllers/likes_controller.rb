class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_like,  only: [:show, :destroy]
  before_action :check_correct_user, only: :destroy

  def create
    @current_micropost = Micropost.find(params[:micropost_id])
    @like = current_user.likes.create!(micropost: @current_micropost)
    current_user.create_like_notification(@current_micropost)
    respond_to do |format|
      format.html { redirect_to @current_micropost }
      format.js
    end

  end

  def destroy
    @current_micropost = @like.micropost
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @current_micropost }
      format.js
    end
  end

  private

    def set_user_and_like
      @like = Like.find(params[:id])
      @user = @like.user
    end

end
