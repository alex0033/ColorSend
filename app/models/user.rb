class User < ApplicationRecord
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :microposts, dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :likes,      dependent: :destroy

  has_many :active_notifications,  class_name: "Notification",
                                  foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",
                                  foreign_key: "visited_id", dependent: :destroy
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
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def create_comment_notification(micropost)
    active_notifications.create!( visited: micropost.user,
                               micropost: micropost,
                                which_do: "コメント" )
  end

  def create_like_notification(micropost)
    active_notifications.create!( visited: micropost.user,
                                micropost: micropost,
                                 which_do: "いいね" )
  end


  protected
    # emailがnilのときバリデーションが働かないようにする
    def email_required?
      email_blank_to_nil
      self.email
    end

  private
    #emailがblankならnilとして処理する
    def email_blank_to_nil
     if self.email.blank?
       self.email = nil
     end
    end
end
