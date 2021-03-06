class Micropost < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :image, attached: true,
                    content_type: { in: %w[image/jpeg image/png],
                               message: "must be a valid image format" },
                    size: { less_than: 5.megabytes,
                              message: "should be less than 5MB" }

  default_scope -> { order(created_at: :desc) }

  def display_image
    image.variant(resize_to_fill: [300, 300])
  end

  def Micropost.search(search)
    Micropost.where(['title LIKE ?', "%#{search}%"])
  end

end
