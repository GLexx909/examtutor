class Progress < ApplicationRecord
  MONTH = %w(Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь)

  belongs_to :user

  validates :user_id, :date, :points, presence: true
end
