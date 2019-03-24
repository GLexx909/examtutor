class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :courses, through: :course_passages
  has_many :course_passages, dependent: :destroy
  has_many :moduls, through: :modul_passages
  has_many :modul_passages, dependent: :destroy
  has_many :topics, through: :topic_passages
  has_many :topic_passages, dependent: :destroy
  has_many :essays, through: :essay_passages
  has_many :essay_passages, dependent: :destroy

  scope :not_admin, -> { where(admin: false) }

  def author_or_admin_of?(resource)
    (id == resource.author_id) || admin?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def have_course?(course)
    course_passages.find_by(course_id: course)
  end
end
