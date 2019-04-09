class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :message, only: [:create]
  after_action :publish_message, only: [:create]
  after_action :delete_message, only: [:destroy]

  authorize_resource

  def abonents
    @abonents = Message.penpals(current_user)
  end

  def create
    message.abonent = abonent
    message.save
  end

  def index
    @messages = abonent.messages_with(current_user)
    abonent
    gon.current_user_id = current_user.id
  end

  def destroy
    message.destroy if can?(:destroy, message)
    head :ok
  end

  private

  helper_method :pelpals_users

  def message
    @message ||= params[:id] ? Message.find(params[:id]) : current_user.messages.new(messages_params)
  end

  def abonent
    @abonent ||= User.find(params[:abonent_id])
  end

  def publish_message
    return if message.errors.any?
    ActionCable.server.broadcast("correspondence_of_#{pelpals_users[0]}_and_#{pelpals_users[1]}", action: 'create', message: message, is_admin?: current_user.admin?)
  end

  def delete_message
    ActionCable.server.broadcast("correspondence_of_#{pelpals_users[0]}_and_#{pelpals_users[1]}", action: 'delete', message_id: message.id)
  end

  def pelpals_users
    [current_user.id, abonent.id].sort
  end

  def messages_params
    params.require(:message).permit(:body)
  end
end
