class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :course_passages, dependent: :destroy
  has_many :courses, through: :course_passages
  has_many :modul_passages, dependent: :destroy
  has_many :moduls, through: :modul_passages
  has_many :topic_passages, dependent: :destroy
  has_many :topics, through: :topic_passages
  has_many :essay_passages, dependent: :destroy
  has_many :essays, through: :essay_passages
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :question_passages, dependent: :destroy
  has_many :questions, through: :question_passages
  has_many :notifications, foreign_key: 'abonent_id', dependent: :destroy
  has_many :messages, foreign_key: 'author_id'
  has_many :abonents, through: :messages

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

  def messages_with(abonent)
    Message.where("author_id = #{self.id} AND abonent_id = #{abonent.id} OR author_id = #{abonent.id} AND abonent_id = #{self.id}")
  end
end
