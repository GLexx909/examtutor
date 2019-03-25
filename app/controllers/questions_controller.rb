class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :question, only: [:new, :edit]

  authorize_resource

  def new
    question.answers.new
  end

  def create
    @question = test.questions.create(question_params)
  end

  def edit
  end

  def update
    question.update(question_params)
  end

  def destroy
    question.destroy
  end

  private

  def test
    @test = Test.find(params[:test_id])
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : test.questions.new
  end

  def question_params
    params.require(:question).permit(:title, answers_attributes: [:id, :body, :correct, :_destroy])
  end
end
