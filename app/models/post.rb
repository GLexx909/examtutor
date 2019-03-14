class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true

  scope :of_admin, -> { select { |post| post.user.admin? } }
end
