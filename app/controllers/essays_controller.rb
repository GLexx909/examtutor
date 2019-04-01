class EssaysController < ApplicationController
  before_action :authenticate_user!
  before_action :essay, only: [:new, :show, :edit]

  authorize_resource

  add_breadcrumb 'Курсы', :courses_path

  def new
  end

  def show
    bread_crumbs
    @essay_passage = essay.essay_passage(current_user)
  end

  def create
    @essay = modul.essays.create(essay_params)
  end

  def edit
  end

  def update
    essay.update(essay_params)
  end

  def destroy
    essay.destroy
    redirect_to essay.modul
  end

  private

  helper_method :admin

  def modul
    @modul ||= Modul.find(params[:modul_id])
  end

  def essay
    @essay ||= params[:id] ? Essay.find(params[:id]) : modul.essays.new
  end

  def bread_crumbs
    add_breadcrumb "Модули", course_path(essay.modul.course)
    add_breadcrumb "Модуль #{essay.modul.title}", modul_path(essay.modul)
  end

  def admin
    User.find_by(admin: true)
  end

  def essay_params
    params.require(:essay).permit(:title)
  end
end
