class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :test, only: [:new, :show, :edit]

  authorize_resource

  add_breadcrumb 'Курсы', :courses_path

  def new
  end

  def show
    bread_crumbs
  end

  def create
    @test = modul.tests.create(test_params)
  end

  def edit
  end

  def update
    test.update(test_params)
  end

  def destroy
    test.destroy
    redirect_to test.modul
  end

  private

  def modul
    @modul ||= Modul.find(params[:modul_id])
  end

  def test
    @test ||= params[:id] ? Test.find(params[:id]) : modul.tests.new
  end

  def bread_crumbs
    add_breadcrumb "Модули", course_path(test.modul.course)
    add_breadcrumb "Модуль #{test.modul.title}", modul_path(test.modul)
  end

  def test_params
    params.require(:test).permit(:title)
  end
end
