class WeeklyDigestMailer < ApplicationMailer
  def digest(user, email, description, points, attendances)
    @user = user
    @email = email
    @description = description
    @points = points
    @attendances = attendances

    mail to: email
  end
end
