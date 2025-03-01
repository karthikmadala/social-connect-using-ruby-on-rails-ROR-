class CreateFriendships < ActiveRecord::Migration[8.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }  # References users table
      t.references :friend, null: false, foreign_key: { to_table: :users } # References users table
      t.string :status, default: "pending" # Status can be "pending", "accepted", "declined"

      t.timestamps
    end
  end
end
