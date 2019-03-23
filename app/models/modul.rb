class Modul < ApplicationRecord
  has_many :users, through: :modul_passages
  has_many :modul_passages, dependent: :destroy
  has_many :topics

  belongs_to :course

  validates :title, presence: true
end
