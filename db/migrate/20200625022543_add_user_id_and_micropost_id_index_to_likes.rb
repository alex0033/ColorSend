class AddUserIdAndMicropostIdIndexToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, :user_id
    add_index :likes, :micropost_id
  end
end
