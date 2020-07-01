class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if user_params = params && params[:user]
      @user.password              = user_params[:password]
      @user.password_confirmation = user_params[:password_confirmation]
    else
      flash.now[:alert] = "予期せぬエラーです"
      render 'passwords/edit' and return
    end
    current_password_check = @user.reload.valid_password?(params[:user][:current_password])
    if @user.valid? && current_password_check
      @user.reset_password(@user.password, @user.password_confirmation)
      flash[:notice] = "パスワードを変更しました"
      bypass_sign_in @user
      redirect_to @user and return
    elsif !(current_password_check)
      flash.now[:alert] = "\"今のパスワード\"が間違っています"
    end
    render 'passwords/edit'
  end

end
