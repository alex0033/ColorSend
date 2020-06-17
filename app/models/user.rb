class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :name,      presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 }

  # このメソッドでは、uidと一致するユーザーをDBから探す
  # 無ければ新たに作る（この時点でsaveはされない）
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      # user.password = Devise.friendly_token[0, 20]　パスワードは自分で入力してもらう
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
  #       user.email = data['email'] if user.email.blank?
  #     end
  #   end
  # end

end
