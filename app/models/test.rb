class Test < ApplicationRecord
  has_many :users, through: :test_passages
  has_many :test_passages, dependent: :destroy
  has_many :questions, dependent: :destroy

  belongs_to :modul

  validates :title, presence: true
end
