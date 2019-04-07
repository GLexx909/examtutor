class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :message, only: [:create]

  authorize_resource

  def abonents
    @abonents = Message.penpals(current_user)
  end

  def create
    message.abonent = abonent
    message.save
  end

  private

  def message
    @message ||= params[:id] ? Message.find(params[:id]) : current_user.messages.new(messages_params)
  end

  def abonent
    @abonent ||= User.find(params[:abonent_id])
  end

  def messages_params
    params.require(:message).permit(:body)
  end
end
