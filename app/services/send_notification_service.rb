class Services::SendNotificationService

  def initialize(title, link, abonent, author, **type)
    @title = title
    @link = link
    @abonent = abonent
    @author = author
    @type = type[:type]
  end

  def send
    abonents = @abonent.is_a?(ActiveRecord::Relation) ?  @abonent : [@abonent]
    create_notification(abonents)
  end

  private

  def create_notification(abonents)
    abonents.each do |abonent|
      notification = Notification.new(title: @title, link: @link)
      notification.abonent = abonent
      notification.author = @author
      notification.type_of = @type
      notification.save
      send_notification(notification)
    end
  end

  def send_notification(notification)
    ActionCable.server.broadcast("notify_user_#{notification.abonent.id}", { notification: notification, link: link } )
  end

  def link
    @link&.gsub(/\//, '%2F')
  end
end
