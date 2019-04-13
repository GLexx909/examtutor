class Test < ApplicationRecord
  has_many :users, through: :test_passages
  has_many :test_passages, dependent: :destroy
  has_many :questions, dependent: :destroy, as: :questionable

  belongs_to :modul

  validates :title, presence: true

  def current_points(current_user)
    test_passage(current_user).points
  end

  def test_passage(current_user)
    test_passages.find_by(user: current_user)
  end

  def all_points
    # It is the maximum number of points
    all_points = questions.inject(0) do |memo, question|
      memo += question.answer.points
    end
    all_points
  end
end
