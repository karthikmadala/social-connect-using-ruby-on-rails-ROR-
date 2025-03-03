class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User"

  scope :unread, -> { where(read: false) }

  validates :message, presence: true
end
