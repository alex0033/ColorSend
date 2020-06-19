class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :name,      presence: true,  length: { maximum: 50 }
  validates :user_name, presence: true,  length: { maximum: 50 }
  validates :uid,       presence: true,  uniqueness: true
  validates :self_introduction, length: { maximum: 500 }
  validates :website,           length: { maximum: 500 }
  validates :gender,            length: { maximum: 30 }
  validates :image,             presence: true

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

  protected

    # emailがnilのときバリデーションが働かない
    def email_required?
      email_blank_to_nil
      self.email
    end


  private

     def email_blank_to_nil
       if self.email.blank?
         self.email = nil
       end
     end
end
