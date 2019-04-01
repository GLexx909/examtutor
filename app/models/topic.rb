class Topic < ApplicationRecord
  has_many :users, through: :topic_passages
  has_many :topic_passages, dependent: :destroy
  has_many :questions, dependent: :destroy, as: :questionable

  belongs_to :modul

  validates :title, :body, presence: true
end
