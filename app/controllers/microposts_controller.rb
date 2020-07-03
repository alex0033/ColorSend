class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_micropost, only: [:show, :destroy]
  before_action :check_correct_user,     only: :destroy

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.build(title: params[:micropost][:title])
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:notice] = "投稿しました"
      redirect_to @micropost
    else
      render 'microposts/new'
    end
  end

  def show
    @comment   = Comment.new
    @comments  = @micropost.comments
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to root_url
  end

  private

    def set_user_and_micropost
      @micropost = Micropost.find(params[:id])
      @user      = User.find(@micropost.user_id)
    end

end
