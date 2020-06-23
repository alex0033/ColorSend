class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(content: params[:comment][:content])

    # render先でも使うために
    # micropost_idではなく、micropostを利用
    @micropost = Micropost.find(params[:micropost_id])
    @comment.micropost = @micropost
    if @comment.save
      redirect_to @micropost and return
    else
      @comments = @micropost.comments
      render 'microposts/show'
    end
  end

  def destroy

  end

  private

  # def comment_params
  #   params.require(:comment).permit(:comment, :micropost_id)
  # end

end
