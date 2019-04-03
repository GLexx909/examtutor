class Modul < ApplicationRecord
  has_many :users, through: :modul_passages
  has_many :modul_passages, dependent: :destroy
  has_many :topics
  has_many :essays
  has_many :tests

  belongs_to :course

  validates :title, presence: true

  def modul_passage(current_user)
    modul_passages.find_by(user: current_user)
  end

  def over?(current_user)
    status = true

    topics.each do |topic|
      status = false unless topic.topic_passage(current_user)&.status?

    end

    essays.each do |essay|
      status = false unless essay.essay_passage(current_user)&.status?
    end

    tests.each do |test|
      status = false unless test.test_passage(current_user)&.status?
    end

    status
  end
end
