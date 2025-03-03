class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.string :message, null: false
      t.boolean :read, default: false  # <-- Setting default value here

      t.timestamps
    end
  end
end
