class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :course, only: [:new, :edit, :update]

  authorize_resource

  def index
    @courses = Course.all
  end

  def new
  end

  def create
    @course = Course.create(course_params)
  end

  def edit
  end

  def update
    @course.update(course_params)
  end

  def course
    @course ||= params[:id] ? Course.find(params[:id]) : Course.new
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end
end
