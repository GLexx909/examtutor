class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: 'post_id', dependent: :destroy

  has_many_attached :files, dependent: :purge_later

  validates :title, :body, presence: true

  default_scope -> { order(created_at: :desc) }
  scope :of_admin, -> { joins(:author).where(users: { admin: true }) }
  scope :of_user, -> (user) { where(author: user) }
  scope :for_guests, -> { where(for_guests: true) }
end
