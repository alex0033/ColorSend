# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params,        only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # facebook認証後のみサインアップページへ行ける
  # nameとuidのみ取り出し、利用する
  def new
    if auth = session["devise.facebook_data"]
      auth_uid = auth["uid"]
      @name    = auth["info"]["name"]
    end
    uid_filter auth_uid
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(user_hash)
    uid_filter @user.uid
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'devise/registrations/new'
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_name])
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end

  private

    # nameはparamsの値を優先させる
    def user_hash
      auth = session["devise.facebook_data"]
      user = params[:user]
      {
        name:                  user[:name],
        user_name:             user[:user_name],
        password:              user[:password],
        password_confirmation: user[:password_confirmation],

        email:     auth["info"]["email"],
        image:     auth["info"]["image"],
        provider:  auth["provider"],
        uid:       auth["uid"],
      }
    end

    def uid_filter(uid)
      if uid.blank?
        flash[:danger] = "Please click 'さぁ、はじめよう' to login facebook."
        redirect_to root_url
      end
    end

end
