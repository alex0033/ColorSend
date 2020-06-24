class Micropost < ApplicationRecord
  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :likes,    dependent: :destroy

  has_one_attached :image

  validates :image, attached: true,
                    content_type: { in: %w[image/jpeg image/png],
                               message: "must be a valid image format" },
                    size: { less_than: 5.megabytes,
                              message: "should be less than 5MB" }

  default_scope -> { order(created_at: :desc) }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

end
