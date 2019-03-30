class Essay < ApplicationRecord
  has_many :users, through: :essay_passages
  has_many :essay_passages, dependent: :destroy

  belongs_to :modul

  validates :title, presence: true

  def essay_passage(current_user)
    essay_passages.find_by(user: current_user)
  end
end
