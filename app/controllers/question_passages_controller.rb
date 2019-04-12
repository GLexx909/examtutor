class QuestionPassagesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  add_breadcrumb 'Курсы', :courses_path

  def create
    if question.question_passages.find_by(user: current_user)
      head :found
    else
      @question_passage = question.question_passages.create(user: current_user, answer: params[:answer])

      result = Services::PointsCounterService.new(@question_passage, current_user).check_answer
      render json: { user_answer: @question_passage.answer,
                     real_answer: @question_passage.question.answer.body,
                     id: @question_passage.question.id,
                     result: result,
                     points: @question_passage.points, all_points: all_points}
    end
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def all_points
    question.points(current_user) if question.questionable_type == 'Test'
  end
end
