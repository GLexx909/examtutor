class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :course, only: [:new, :show, :update, :destroy]

  authorize_resource
  add_breadcrumb "Курсы:", :courses_path, :title => "Все курсы"

  def index
    @courses = Course.all
  end

  def new
  end

  def show
    bread_crumbs
  end

  def create
    @course = Course.create(course_params)
  end

  def update
    @course.update(course_params)
    render json: { title: @course.title, id: @course.id, errors: @course.errors }
  end

  def destroy
    @course.destroy
  end

  private

  def course
    @course ||= params[:id] ? Course.find(params[:id]) : Course.new
  end

  def bread_crumbs
    add_breadcrumb "Курс #{course.title}", course_path(course.id)
  end

  def course_params
    params.require(:course).permit(:title)
  end
end
