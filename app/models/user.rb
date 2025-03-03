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

  def full_name
    "#{first_name} #{last_name}"
  end
end
