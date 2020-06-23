class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
