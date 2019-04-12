class Answer < ApplicationRecord
  belongs_to :question

  validates :body, :points, presence: true

  def is_number?
    body.to_i != 0
  end
end
