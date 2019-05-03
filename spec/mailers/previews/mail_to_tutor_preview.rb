# Preview all emails at http://localhost:3000/rails/mailers/mail_to_tutor
class MailToTutorPreview < ActionMailer::Preview
  def send_mail
    MailToTutorMailer.send_mail(message, author)
  end

  private

  def message
    'Lorem Ipsum has been the industrys standard dummy'
  end

  def author
    User.last
  end
end
