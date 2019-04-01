class NotificationsController < ApplicationController
  before_action :authenticate_user!
  after_action :send_notification, only: [:create]

  authorize_resource

  def index
    @notifications = Notification.where(abonent: current_user).or(Notification.where(abonent: nil)).order(created_at: :desc)
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.abonent = abonent
    @notification.save
    Services::NotificationAdditionalActions.new(params).action
  end

  def update
    notification.update(status: true)
    redirect_to params[:link]
  end

  private

  def send_notification
    ActionCable.server.broadcast("notify_user_#{params[:notification][:abonent]}", { notification: params[:notification] } )
  end

  def notification
    @notification ||= Notification.find(params[:id])
  end

  def abonent
    User.find(params[:notification][:abonent]) if params[:notification][:abonent]
  end

  def notification_params
    params.require(:notification).permit(:title, :link)
  end
end
