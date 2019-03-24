class QuestionsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def new
    @question = test.questions.new
  end

  def create

  end

  private

  def test
    @test = Test.find(params[:test_id])
  end
end
