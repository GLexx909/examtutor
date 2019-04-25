class MailToTutorMailer < ApplicationMailer
  def send_mail(message, author)
    @message = message
    @author = author
    mail to: 'info@examtutor.ru'
  end
end
