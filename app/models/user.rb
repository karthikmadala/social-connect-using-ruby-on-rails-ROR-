class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :friendships
  has_many :accepted_friendships, -> { where(status: "accepted") }, class_name: "Friendship"
  has_many :pending_friendships, -> { where(status: "pending") }, class_name: "Friendship"

  has_many :friends, -> { where(friendships: { status: "accepted" }) }, through: :friendships
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :received_friend_requests, class_name: "Friendship", foreign_key: "friend_id"
  has_many :sent_friend_requests, class_name: "Friendship", foreign_key: "user_id"
  has_many :notifications, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :mentions, dependent: :destroy
  has_many :mentioned_posts, through: :mentions, source: :post
  has_many :comments, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  def liked?(post)
    likes.exists?(post_id: post.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # Suggested friends based on mutual connections
  def suggested_friends
    User.where.not(id: self.id).joins(:friendships)
        .where(friendships: { friend_id: friends.pluck(:id) })
        .where.not(friendships: { user_id: self.id })
        .distinct
  end

  def friendship_status(other_user)
    friendship = friendships.find_by(friend_id: other_user.id)
    return "Friends" if friendship&.status == "accepted"
    return "Pending" if friendship&.status == "pending"
    "Add Friend"
  end
end
