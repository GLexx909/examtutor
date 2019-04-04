class ModulsController < ApplicationController
  before_action :authenticate_user!, except: [:sort]
  before_action :modul, only: [:new, :show, :edit]
  skip_before_action :verify_authenticity_token, only: [:sort]

  authorize_resource

  add_breadcrumb 'Курсы', :courses_path

  def new
  end

  def show
    redirect_to course_path(modul.course) unless modul.modul_passage(current_user)&.status? || can?(:manage, :all)
    bread_crumbs
  end

  def create
    @modul = course.moduls.create(modul_params)
    create_new_modul_passages(@modul)
  end

  def edit
  end

  def update
    modul.update(modul_params)
  end

  def destroy
    modul.destroy
  end

  def sort
    params[:modul].each_with_index do |id, index|
      Modul.find(id).update(position: index+1)
    end

    head :ok
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end

  def modul
    @modul ||= params[:id] ? Modul.find(params[:id]) : course.moduls.new
  end

  def create_new_modul_passages(modul)
    modul.course.users do |user|
      modul.create.modul_passage(user: user)
    end
  end

  def bread_crumbs
    add_breadcrumb "Модули", course_path(modul.course), :title => "Модули"
    add_breadcrumb "Модуль #{modul.title}"
  end

  def modul_params
    params.require(:modul).permit(:title)
  end
end
