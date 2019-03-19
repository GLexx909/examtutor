class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  default_scope -> { order(created_at: :desc) }
  scope :of_admin, -> { select { |post| post.author.admin? } }
  scope :of_user, -> (user) { select { |post| post.author == user } }
  scope :for_guests, -> { where(for_guests: true) }
end
