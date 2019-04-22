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
  has_many :notifications, foreign_key: 'author_id', dependent: :destroy
  has_many :messages, foreign_key: 'author_id', dependent: :destroy
  has_many :messages, foreign_key: 'abonent_id', dependent: :destroy
  has_many :abonents, through: :messages
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_one :characteristic, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :progresses, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :feedback

  has_one_attached :avatar, dependent: :purge_later

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

  def notifications_from_penpals(abonent)
    Notification.where(abonent: self, author: abonent, type_of: 'message', status: false)
  end

  def notifications_type_message
    Notification.where(abonent: self, type_of: 'message')
  end

  def uniq_notifications_of_message
    uniq_titles = self.notifications_type_message.pluck(:title).uniq
    notifications = []
    uniq_titles.each do |title|
      notifications << Notification.all_of_user(self).where(title: title).first
    end
    notifications
  end

  def all_uniq_notifications
    all_notification = Notification.all_of_user(self)
    all_notification -= Notification.where(abonent: self, type_of: 'message')
    uniq_notifications_of_message = self.uniq_notifications_of_message

    all_notification + uniq_notifications_of_message
  end

  def author_of?(resource)
    id == resource.author_id
  end

  def profile_avatar
    avatar.attached? ? avatar : 'no-photo.jpg'
  end

  def nav_avatar
    avatar.attached? ? avatar : 'no-photo-sm.jpg'
  end

  def identify_name
    "#{last_name}-#{id}"
  end
end
