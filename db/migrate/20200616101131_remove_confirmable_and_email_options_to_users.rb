class RemoveConfirmableAndEmailOptionsToUsers < ActiveRecord::Migration[6.0]
  def change
    # remove_index :users, :confirmation_token
    # remove_index :users, :name
    #
    # remove_column :users, :confirmation_token
    # remove_column :users, :confirmed_at
    # remove_column :users, :confirmation_sent_at
    # remove_column :users, :unconfirmed_email
    # remove_column :users, :email
    #
    # add_column :users, :email
    # add_column :users, :user_name
  end
end
