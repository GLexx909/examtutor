class TestsController < ApplicationController
  add_breadcrumb 'Курсы', :courses_path

  before_action :authenticate_user!
  before_action :test, only: [:start, :new, :show, :edit]
  before_action :bread_crumbs, only: [:show, :start]

  authorize_resource

  def start
    if test_passage
      test_passage.update(left_time: left_time)
      test_passage.update(status: true, left_time: 0) if left_time <= 0
    else
      test.test_passages.create(user: current_user, left_time: test.timer)
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

  def test_passage
    test.test_passage(current_user)
  end

  def left_time
    test.timer - ((Time.now - test_passage.created_at)/60).ceil
  end

  def bread_crumbs
    add_breadcrumb "Модули", course_path(test.modul.course)
    add_breadcrumb "Модуль #{test.modul.title}", modul_path(test.modul)
  end

  def test_params
    params.require(:test).permit(:title, :timer)
  end
end
