class Course < ApplicationRecord
  has_many :users, through: :course_passages
  has_many :course_passages, dependent: :destroy

  validates :title, presence: true
end