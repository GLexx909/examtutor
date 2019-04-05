class Services::SendNotificationService

  def initialize(title, link, abonent)
    @title = title
    @link = link
    @abonent = abonent
  end

  def send
    notification = Notification.new(title: @title, link: @link)
    notification.abonent = @abonent
    notification.save
    send_notification(notification)
  end

  private

  def send_notification(notification)
    ActionCable.server.broadcast("notify_user_#{@abonent.id}", { notification: notification, link: link } )
  end

  def link
    @link&.gsub(/\//, '%2F')
  end
end
