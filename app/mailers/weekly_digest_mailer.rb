class WeeklyDigestMailer < ApplicationMailer
  def digest(email, description, points, attendances)
    @email = email
    @description = description
    @points = points
    @attendances = attendances

    mail to: email
  end
end
