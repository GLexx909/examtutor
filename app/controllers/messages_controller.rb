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
    message.author = current_user
    message.save
    Services::SendNotificationService.new("Сообщение от #{current_user.full_name}", messages_path(abonent_id: current_user.id), abonent, current_user, type: 'message').send
  end

  def index
    @messages = abonent.messages_with(current_user).order(created_at: :asc)
    abonent
    update_notifications(abonent)
    gon.current_user_id = current_user.id
  end

  def destroy
    if can?(:destroy, message)
      message.destroy
    else
      head 403
    end

    head :ok
  end

  private

  helper_method :pelpals_users

  def message
    @message ||= params[:id] ? Message.find(params[:id]) : Message.new(messages_params)
  end

  def abonent
    @abonent ||= User.find(params[:abonent_id])
  end

  def publish_message
    return if message.errors.any?

    # To get url address from each file
    urls = message.files.inject([]) do |memo, file|
      memo << url_for(file)
    end

    ActionCable.server.broadcast("correspondence_of_#{pelpals_users[0]}_and_#{pelpals_users[1]}",
                                 action: 'create',
                                 message: message,
                                 files: message.files_info_hash(urls),
                                 is_admin?: current_user.admin?)
  end

  def delete_message
    ActionCable.server.broadcast("correspondence_of_#{pelpals_users[0]}_and_#{pelpals_users[1]}", action: 'delete', message_id: message.id)
  end

  def pelpals_users
    [current_user.id, abonent.id].sort
  end

  def update_notifications(abonent)
    current_user.notifications_from_penpals(abonent).update_all(status: true)
  end

  def messages_params
    params.require(:message).permit(:body, files: [])
  end
end
