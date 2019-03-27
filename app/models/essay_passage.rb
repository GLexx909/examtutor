class EssayPassage < ApplicationRecord
  belongs_to :user
  belongs_to :essay

  validates :body, presence: true
end
