class Notification < ApplicationRecord
  belongs_to :abonent, foreign_key:  'abonent_id', class_name: 'User', optional: true
  belongs_to :author, foreign_key:  'author_id', class_name: 'User', optional: true

  scope :all_of_user, ->(current_user) { where(abonent: current_user).or(where(abonent: nil)).order(created_at: :desc) }
end
