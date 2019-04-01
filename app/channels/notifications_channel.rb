class NotificationsChannel < ApplicationCable::Channel
  def follow
    stream_from "notify_user_#{params[:id]}"
  end
end
