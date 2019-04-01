class Notification < ApplicationRecord
  belongs_to :abonent, class_name: 'User', optional: true
end
