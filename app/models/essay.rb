class Essay < ApplicationRecord
  has_many :users, through: :essay_passages
  has_many :essay_passages, dependent: :destroy

  belongs_to :modul

  validates :title, presence: true
end
