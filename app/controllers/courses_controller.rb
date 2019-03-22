class CoursesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @courses = Course.all
  end

  def edit
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end
end
