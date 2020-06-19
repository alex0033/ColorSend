class ChangeColumsToUser < ActiveRecord::Migration[6.0]
  # 変更内容
  def up
    change_column :users, :uid,       :string, null: false, default: ""
    change_column :users, :name,      :string, null: false, default: ""
    change_column :users, :user_name, :string, null: false, default: ""
  end

  # 変更前の状態
  def down
    change_column :users, :uid,       :string
    change_column :users, :name,      :string
    change_column :users, :user_name, :string
  end
end
