class NotificationsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @notifications = Notification.where(abonent: current_user).or(Notification.where(abonent: nil)).order(created_at: :desc)
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.abonent = abonent
    @notification.save
    Services::NotificationAdditionalActions.new(params, current_user).action
    send_notification(@notification)
  end

  def update
    notification.update(status: true) unless notification.status?
    redirect_to params[:link]
  end

  private

  def send_notification(notification)
    ActionCable.server.broadcast("notify_user_#{params[:notification][:abonent]}", { notification: params[:notification], notification_id: notification.id, link: link } )
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

  def link
    params[:notification][:link]&.gsub(/\//, '%2F')
  end
end
