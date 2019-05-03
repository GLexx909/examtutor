class Services::MailToTutorService
  def send_mail(message, author)
    MailToTutorMailer.send_mail(message, author).deliver_later
  end
end
