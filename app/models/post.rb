class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  default_scope -> { order(created_at: :desc) }
  scope :of_admin, -> { joins(:author).where(users: { admin: true }) }
  scope :of_user, -> (user) { where(author: user) }
  scope :for_guests, -> { where(for_guests: true) }
end
