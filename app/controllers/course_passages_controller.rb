class CoursePassagesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def new
   @course_passage = CoursePassage.new
  end

  def create
    @course_passage = CoursePassage.find_by(course_passage_params)
    @course_passage = CoursePassage.create(course_passage_params) if !@course_passage # Do not create, if course_passage is already exist.
  end

  private

  def course_passage_params
    params.require(:course_passage).permit(:user_id, :course_id)
  end
end
