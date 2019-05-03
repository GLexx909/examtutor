class ProgressesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def new
  end

  def create
    @progress = Progress.create(user: user, date: string_date, points: points ) unless Progress.find_by(user: user, date: string_date) #create if not exist yet
  end

  def edit
    progress
  end

  def update
    progress.update(user: user, date: string_date, points: points )
  end

  private

  def progress
    @progress ||= Progress.find(params[:id])
  end

  def string_date
    "#{month_name} #{params[:progress]['date(1i)']}"
  end

  def user
    @user ||= User.find(params[:progress][:user_id])
  end

  def points
    params[:progress][:points]
  end

  def month_name
    number = params[:progress]['date(2i)']
    Progress::MONTH[number.to_i - 1]
  end
end
