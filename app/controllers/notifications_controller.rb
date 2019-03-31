class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :send_notification, only: [:create]

  authorize_resource

  def create
    Notification.create(notification_params)
    Services::NotificationAdditionalActions.new(params).action
  end

  private

  def send_notification
    ActionCable.server.broadcast("notify_user_#{params[:notification][:abonent]}", { notification: params[:notification] } )
  end

  def notification_params
    params.require(:notification).permit(:abonent, :title, :link)
  end
end
