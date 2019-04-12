class Question < ApplicationRecord
  has_many :question_passages, dependent: :destroy
  has_many :users, through: :question_passages

  has_one :answer, dependent: :destroy, inverse_of: :question

  belongs_to :questionable, polymorphic: true

  validates :title, presence: true

  accepts_nested_attributes_for :answer, reject_if: :all_blank

  def test_passage(user)
    questionable.test_passages.find_by(user: user)
  end

  def topic_passage(user)
    questionable.topic_passages.find_by(user: user)
  end

  def question_passage(user)
    question_passages.find_by(user: user)
  end

  def points(user)
    test_passage(user).points
  end
end
