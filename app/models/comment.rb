class Comment < ApplicationRecord
  include Votable
  belongs_to :author, class_name: 'User'
  belongs_to :post, touch: true

  validates :body, presence: true
end
