class Feedback < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  scope :approved, -> { where(approved: true) }
  scope :moderation, -> { where(moderation: true) }
end
