class MailersController < ApplicationController
  skip_authorization_check

  def create
    MailerToTutorJob.perform_now(message, author)
  end

  private

  def message
    @message ||= params[:message]
  end

  def author
    id = request.referer.split('/').last.to_i
    User.find(id).full_name
  end
end
