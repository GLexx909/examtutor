class Test < ApplicationRecord
  has_many :users, through: :test_passages
  has_many :test_passages, dependent: :destroy
  has_many :questions, dependent: :destroy, as: :questionable

  belongs_to :modul

  validates :title, :timer, presence: true

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

  def ready_to_show?(current_user)
    status = true

    modul.topics.each do |topic|
      status = false unless topic.topic_passage(current_user)&.status?
    end

    modul.essays.each do |essay|
      status = false unless essay.essay_passage(current_user)&.status?
    end

    status
  end
end
