class CoursesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @courses = Course.all
  end

  def edit
    @course = Course.find(params[:id])
  end
end
