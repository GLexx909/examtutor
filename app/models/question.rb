class Question < ApplicationRecord
  has_many :question_passages, dependent: :destroy
  has_many :users, through: :question_passages

  has_one :answer, dependent: :destroy, inverse_of: :question

  belongs_to :test

  validates :title, presence: true

  accepts_nested_attributes_for :answer, reject_if: :all_blank

  def test_passage(user)
    test.test_passages.find_by(user: user)
  end

  def points(user)
    test_passage(user).points
  end
end
