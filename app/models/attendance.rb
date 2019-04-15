class Attendance < ApplicationRecord
  belongs_to :user

  validates :user, :description, :color, presence: true
end
