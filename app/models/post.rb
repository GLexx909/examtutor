class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  scope :of_admin, -> { select { |post| post.author.admin? } }
  scope :of_user, -> (user) { select { |post| post.author == user } }
end
