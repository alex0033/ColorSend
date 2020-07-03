class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.references :micropost, null: false, foreign_key: true
      t.boolean :checked, default: false, nul: false
      t.string :which_do

      t.timestamps
    end
    add_index :notifications, :visiter_id
    add_index :notifications, :visited_id
  end
end
