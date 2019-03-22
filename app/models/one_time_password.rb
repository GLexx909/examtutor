class OneTimePassword < ApplicationRecord
  validates :pass_word, presence: true
end
