class Comment < ApplicationRecord
  include Votable
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :body, presence: true
end
