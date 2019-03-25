class Question < ApplicationRecord
  has_one :answer, dependent: :destroy, inverse_of: :question
  belongs_to :test

  validates :title, presence: true

  accepts_nested_attributes_for :answer, reject_if: :all_blank
end
