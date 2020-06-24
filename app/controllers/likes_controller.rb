class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    micropost_id = params[:micropost_id]
    @like = current_user.likes.create(micropost_id: micropost_id)
    redirect_to micropost_path(micropost_id)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to like.micropost
  end

end
