class Services::WeeklyDigestService
  def send_digest
    WeeklyDigest.find_each(batch_size: 500) do |w_d|
      user = w_d.user
      characteristic = user.characteristic

      attendances = user.attendances.where(created_at: Time.now.midnight - 1.week)..Time.now.midnight if user.attendances.present?
      description = characteristic.description
      points = user.progresses.last.points if user.progresses.present?

      WeeklyDigestMailer.digest(w_d.email, description, points, attendances).deliver_later
    end
  end
end
