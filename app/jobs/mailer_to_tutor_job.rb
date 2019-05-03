class MailerToTutorJob < ApplicationJob
  queue_as :default

  def perform(message, author)
    Services::MailToTutorService.new.send_mail(message, author)
  end
end
