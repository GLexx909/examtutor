class TestsController < ApplicationController
  add_breadcrumb 'Курсы', :courses_path

  before_action :authenticate_user!
  before_action :test, only: [:start, :new, :show, :edit]
  before_action :bread_crumbs, only: [:show]

  authorize_resource

  def start
    if test.test_passages.find_by(user: current_user)
      head :found
    else
      test.test_passages.create(user: current_user)
    end
  end

  def new
  end

  def show
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
