class ModulsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def new
    @modul = course.moduls.new
  end

  def create
    @modul = course.moduls.create(modul_params)
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def modul_params
    params.require(:modul).permit(:title)
  end
end
