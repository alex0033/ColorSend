class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  validates :user,      presence: true
  validates :micropost, presence: true
  validates :user, uniqueness: { scope: :micropost }
end
