class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end


  private

     def check_singed_in
       unless user_signed_in?
         flash[:danger] = "Please sign in"
         redirect_to root_url
       end
     end
end
