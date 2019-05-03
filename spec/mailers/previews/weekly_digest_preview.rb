# Preview all emails at http://localhost:3000/rails/mailers/weekly_digest
class WeeklyDigestPreview < ActionMailer::Preview
  def digest
    WeeklyDigestMailer.digest(email, description, points, attendances)
  end

  private

  def email
    'example@mail.ru'
  end

  def description
    'DESCRIPTION Lorem Ipsum has been the industrys standard dummy'
  end

  def points
    67
  end

  def attendances
    User.joins(:attendances).last.attendances
  end
end
