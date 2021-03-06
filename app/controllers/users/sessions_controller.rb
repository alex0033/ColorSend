# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # ルーティングを変更
  def after_sign_in_path_for(resource_or_scope)
    user_path(resource_or_scope)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:user_name])
  end

  # def auth_hash
  #   request.env['omniauth.auth']
  # end
end
