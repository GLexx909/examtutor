class WeeklyDigest < ApplicationRecord
  belongs_to :user

  validates :email, presence: true, format: { with: /.+@.+\..+/i }
  validates :user_id, uniqueness: true
end
