class Services::SendNotificationService

  def initialize(title, link, abonent, author, **type)
    @title = title
    @link = link
    @abonent = abonent
    @author = author
    @type = type[:type]
  end

  def send
    notification = Notification.new(title: @title, link: @link)
    notification.abonent = @abonent
    notification.author = @author
    notification.type_of = @type
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
