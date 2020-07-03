class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_and_comment, only: :destroy
  before_action :check_correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(content: params[:comment][:content])
    # redirect先でも使うために
    # micropost_idではなく、micropostを利用
    @micropost = Micropost.find(params[:micropost_id])
    @comment.micropost = @micropost
    if @comment.save
      current_user.create_comment_notification(@micropost)
      redirect_to @micropost and return
    else
      @comments = @micropost.comments
      render 'microposts/show'
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to @comment.micropost
  end

  private

    def set_user_and_comment
      @comment = Comment.find(params[:id])
      @user    = @comment.user
    end

end
