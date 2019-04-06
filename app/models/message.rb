class Message < ApplicationRecord
  belongs_to :author,  foreign_key:  'author_id', class_name: 'User'
  belongs_to :abonent, foreign_key: 'abonent_id', class_name: 'User'

  validates :body, presence: true

  scope :own, -> (current_user) { where(abonent: current_user).or(where(author: current_user)).order(created_at: :desc) }

  def self.penpals(current_user)
    penpals = Message.own(current_user).inject([]) do |sum, message|
      if message.author != current_user
        sum << message.author
      elsif message.abonent != current_user
        sum << message.abonent
      end
    end
    penpals.uniq
  end
end
