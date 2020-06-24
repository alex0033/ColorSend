class User < ApplicationRecord
  # micropost Modelとの紐付け
  # Userのインスタンスが消えるとMicropostも消える
  has_many :microposts, dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :likes,      dependent: :destroy

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

  # 戻り値としてnilかLikeインスタンスが返る
  def like?(micropost)
    micropost.likes.find_by(user: self)
  end

  def feed
    self.microposts
  end


  protected

    # emailがnilのときバリデーションが働かないようにする
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
