class CoursePassagesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def new
   @course_passage = CoursePassage.new
  end

  def create
    @course_passage = CoursePassage.find_by(course_passage_params)
    @course_passage = CoursePassage.create(course_passage_params) if !@course_passage # Do not create, if course_passage is already exist.
    create_all_modul_passages(@course_passage)
    create_user_characteristic
  end

  private

  helper_method :courses

  def create_all_modul_passages(course_passage)
    course_passage.course.moduls.each { |modul| modul.modul_passages.create(user: user) unless modul.modul_passage(user)}
    course_passage.course.moduls.first.modul_passage(user).update(status: true)
  end

  def courses
    Course.all
  end

  def user
    @user ||= User.find(params[:course_passage][:user_id])
  end

  def create_user_characteristic
    Characteristic.create(user: user) if !user&.characteristic
  end

  def course_passage_params
    params.require(:course_passage).permit(:user_id, :course_id)
  end
end
