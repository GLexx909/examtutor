class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :course, only: [:new, :show,:edit, :update, :destroy]

  authorize_resource

  def index
    @courses = Course.all
  end

  def new
  end

  def show
  end

  def create
    @course = Course.create(course_params)
  end

  def edit
  end

  def update
    @course.update(course_params)
  end

  def destroy
    @course.destroy
  end

  private

  def course
    @course ||= params[:id] ? Course.find(params[:id]) : Course.new
  end

  def course_params
    params.require(:course).permit(:title)
  end
end
