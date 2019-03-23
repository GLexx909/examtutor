class Modul < ApplicationRecord
  has_many :users, through: :modul_passages
  has_many :modul_passages, dependent: :destroy

  validates :title, presence: true
end
