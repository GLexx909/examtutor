class Question < ApplicationRecord
  has_many :answers, dependent: :destroy, inverse_of: :question
  belongs_to :test

  validates :title, presence: true

  accepts_nested_attributes_for :answers, reject_if: :all_blank
end
