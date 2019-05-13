class MailersController < ApplicationController
  skip_authorization_check
  protect_from_forgery with: :null_session

  def create
    MailerToTutorJob.perform_now(message, author)
  end

  private

  def message
    @message ||= params[:message]
  end

  def author
    return "#{params[:name]} #{params[:email]}" if params[:name]
    id = request.referer.split('/').last.to_i
    User.find(id).full_name
  end
end
