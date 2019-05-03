class WeeklyDigestsController < ApplicationController

  skip_authorization_check

  def create
    @weekly_digest = WeeklyDigest.create(user: user, email: email)
  end

  def destroy
    weekly_digest.destroy
  end

  private

  def email
    @email ||= params[:email]
  end

  def user
    id = request.referrer.split('/')[4].to_i
    User.find(id)
  end

  def weekly_digest
    WeeklyDigest.find_by(user: params[:id])
  end
end
