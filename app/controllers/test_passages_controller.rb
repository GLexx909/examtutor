class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :test

  authorize_resource

  add_breadcrumb 'Курсы', :courses_path


  private

  def test
    @test ||= Test.find(params[:test_id])
  end
end
