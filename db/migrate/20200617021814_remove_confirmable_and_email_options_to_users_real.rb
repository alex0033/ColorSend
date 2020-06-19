class RemoveConfirmableAndEmailOptionsToUsersReal < ActiveRecord::Migration[6.0]
# 追加でその他ユーザーに必要な情報（自己紹介など）も追加
  def change
    remove_index :users, :confirmation_token
    remove_index :users, :name

    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :email

    add_column :users, :email,             :string
    add_column :users, :user_name,         :string
    add_column :users, :website,           :string
    add_column :users, :self_introduction, :text
    add_column :users, :phone_number,      :integer
    add_column :users, :gender,            :string
  end
end
