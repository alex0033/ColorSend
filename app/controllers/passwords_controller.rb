# frozen_string_literal: true

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
      # error文不完全
      flash.now[:danger] = "This is an unexpected error."
      render 'passwords/edit' and return
    end
    current_password_check = @user.reload.valid_password?(params[:user][:current_password])
    if @user.valid? && current_password_check &&
        @user.reset_password(@user.password, @user.password_confirmation)
      flash[:success] = "Success edit password"
      bypass_sign_in @user
      redirect_to user_url(@user) and return
    elsif !(current_password_check)
      flash.now[:danger] = "current password is wrong"
    end
    render 'passwords/edit'
  end

end
