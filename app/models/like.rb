class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  validates :user, uniqueness: { scope: :micropost }
end
