class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :attendance, only: [:new, :edit]

  authorize_resource

  def new
    attendance
  end

  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.date += 1.day
    @attendance.color = params[:color]
    @attendance.save
  end

  def edit
    attendance
  end

  def update
    if can?(:update, attendance)
      attendance.color = params[:color]
      attendance.update(attendance_params)
    end
  end

  def destroy
    attendance.destroy if can?(:destroy, attendance)
  end

  private

  def attendance
    @attendance ||= params[:id] ? Attendance.find(params[:id]) : Attendance.new
  end

  def user
    @user ||= User.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:user_id, :description, :color, :date)
  end
end
