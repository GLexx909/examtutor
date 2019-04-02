class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :question, only: [:new, :edit]
  before_action :questionable, only: [:new]

  authorize_resource

  def new
    question.build_answer
  end

  def create
    @question = questionable.questions.create(question_params) if params[:question][:answer_attributes][:body]
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

  def questionable
    if params[:topic_id]
      @questionable = Topic.find(params[:topic_id])
    elsif params[:test_id]
      @questionable = Test.find(params[:test_id])
    end
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : questionable.questions.new
  end

  def question_params
    params.require(:question).permit(:title, answer_attributes: [:id, :body, :full_accordance, :points, :_destroy])
  end
end
