class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :photos  # Allow multiple images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :content, presence: true
  has_many_attached :media_files  # Allows image/video uploads
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions, source: :user

  # Scope to get scheduled posts
  scope :scheduled, -> { where("publish_at > ?", Time.current) }

  def extract_mentions
    # Extract mentions from the content (e.g., @john_doe or @JaneDoe)
    mentioned_names = content.scan(/@\w+/).map { |mention| mention.delete("@") }

    mentioned_names.each do |name|
      # Look for the user by first_name and last_name combination
      user = User.find_by("CONCAT(first_name, ' ', last_name) = ?", name)
      mentions.create(user: user) if user
    end
  end
  def liked?(post)
    likes.exists?(post_id: post.id)
  end
end
