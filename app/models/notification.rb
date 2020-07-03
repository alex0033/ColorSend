class Notification < ApplicationRecord

  belongs_to :micropost
  belongs_to :visiter, class_name: "User", foreign_key: "visiter_id"
  belongs_to :visited, class_name: "User", foreign_key: "visited_id"

  default_scope -> { order(created_at: :desc) }

  validates :visiter_id,   presence: true
  validates :visited_id,   presence: true
  validates :micropost_id, presence: true
  validates :which_do,     presence: true

  def message
    "\"#{visiter.user_name}\"があなたの投稿に#{which_do}しました。"
  end

end
