# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params,        only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  #このコントローラーでは、

  # GET /resource/sign_up
  # facebook認証後のみサインアップページへ行ける
  # nameとuidのみ取り出し、利用する
  def new
    if auth = set_object(session, "devise.facebook_data")
      auth_uid  = auth["uid"]
      uid_filter auth_uid
      @user = User.new
      @user.name = set_object auth["info"], "name"
    else
      authenticate_error
    end
  end

  # POST /resource
  def create
    @user = User.new(user_hash)
    uid_filter @user.uid
    # @userにエラーメッセージを入れるためにsaveの前にvaild?を使用
    if @user.valid? && user_policy_read?
      @user.save
      sign_in @user
      redirect_to @user and return
    elsif !user_policy_read?
      @user.errors.add(:user_policy, "not read user_policy")
    end
    render 'devise/registrations/new'
  end

  # GET /resource/edit
  # def edit
  #   super
  # end


  # PUT /resource
  # @userにcurrent_userが入っている
  def update
    if @user.update(edit_params)
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to @user
    else
      render 'devise/registrations/edit'
    end
  end

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
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_name])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update,
    #     keys: [:name, :user_name, :self_introduction, :email, :website, :gender])
    # end

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
    # nilガードは必要か？？
    def user_hash
      if set_object(params, :user) &&
          check_objects(session, "devise.facebook_data", "info")

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
    end

    def edit_params
      params.require(:user).permit(:name, :user_name, :self_introduction,
                                   :website, :phone_number, :email, :gender)
    end

    def uid_filter(uid)
      if uid.blank?
        authenticate_error
      end
    end

    def authenticate_error
      flash[:alert] = "\"さぁ、はじめよう\"をクリックして、facebook認証を行ってください"
      redirect_to root_url
    end

    # object[keyword]で例外の発生を防ぐ
    # objectがnilならnilを返す
    def set_object(object, keyword)
      item = object && object[keyword]
      return nil unless item
      return item
    end

    def check_objects(object, first_keyword, second_keyword)
      object && object[first_keyword] &&
             object[first_keyword][second_keyword]
    end

    def user_policy_read?
      params[:user][:user_policy] == "1"
    end

end
