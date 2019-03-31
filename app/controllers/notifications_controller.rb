class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :send_notification, only: [:create]

  authorize_resource

  def create
    @notification = Notification.create(notification_params)
  end

  private

  def send_notification
    ActionCable.server.broadcast("notify_user_#{params[:notification][:abonent]}", { notification: params[:notification] } )
  end

  def notification_params
    params.require(:notification).permit(:abonent, :title, :link)
  end
end
