class NotificationsForAllJob < ApplicationJob
  queue_as :default

  def perform(title, link, abonent, author, type)
    Services::SendNotificationService.new(title, link, User.all, author, type: type).send
  end
end
