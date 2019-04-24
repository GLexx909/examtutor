class Message < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :abonent, class_name: 'User'

  has_many_attached :files, dependent: :purge_later

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

  def destroy_files
    files.each { |file| file.purge }
  end

  def files_info_hash(urls)
    all_files = []
    files.each_with_index do |file, index|
      hash = Hash.new
      hash[:name] = file.filename.to_s
      hash[:url] = urls[index]
      all_files << hash
    end
    all_files
  end
end
