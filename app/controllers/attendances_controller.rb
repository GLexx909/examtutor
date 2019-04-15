class AttendancesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def new
    attendance
  end

  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.color = params[:color]
    @attendance.save
  end

  private

  def attendance
    @attendance ||= params[:id] ? Attendance.find(params[:id]) : Attendance.new
  end

  def user
    @user ||= User.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:user_id, :description, :color)
  end
end
