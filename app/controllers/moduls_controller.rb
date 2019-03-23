class ModulsController < ApplicationController
  before_action :authenticate_user!
  before_action :modul, only: [:new, :show, :edit]

  authorize_resource

  def new
  end

  def show
  end

  def create
    @modul = course.moduls.create(modul_params)
  end

  def edit
  end

  def update
    modul.update(modul_params)
  end

  def destroy
    modul.destroy
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def modul
    @modul ||= params[:id] ? Modul.find(params[:id]) : course.moduls.new
  end

  def modul_params
    params.require(:modul).permit(:title)
  end
end
