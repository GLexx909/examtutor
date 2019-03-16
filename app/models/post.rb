class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  scope :of_admin, -> { select { |post| post.author.admin? } }
end
