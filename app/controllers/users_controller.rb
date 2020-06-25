class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user       = User.find(params[:id])
    @microposts = @user.microposts
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

     def check_singed_in
       unless user_signed_in?
         flash[:danger] = "Please sign in"
         redirect_to root_url
       end
     end
end
