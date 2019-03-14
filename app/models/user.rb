class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true, uniqueness: true

  has_many :posts, dependent: :destroy

  def author_of?(resource)
    (id == resource.user_id) || admin?
  end
end
