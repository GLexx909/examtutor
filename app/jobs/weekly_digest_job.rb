class WeeklyDigestJob < ApplicationJob
  queue_as :default

  def perform
    Services::WeeklyDigestService.new.send_digest
  end
end
