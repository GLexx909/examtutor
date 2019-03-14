class Post < ApplicationRecord
  belongs_to :user

  scope :of_admin, -> { select { |post| post.user.admin? } }
end
