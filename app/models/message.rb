class Message < ApplicationRecord
  belongs_to :author,  foreign_key:  'author_id', class_name: 'User'
  belongs_to :abonent, foreign_key: 'abonent_id', class_name: 'User'

  validates :body, presence: true
end
