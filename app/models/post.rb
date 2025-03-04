class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :photos  # Allow multiple images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :content, presence: true
end
