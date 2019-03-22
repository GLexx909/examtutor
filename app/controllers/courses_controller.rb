class CoursesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @courses = Course.all
  end
end
