class AddPublishAtToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :publish_at, :datetime
  end
end
