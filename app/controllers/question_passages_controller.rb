class QuestionPassagesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  add_breadcrumb 'Курсы', :courses_path

  def create
    if question.question_passages.find_by(user: current_user)
      head :found
    else
      @question_passage = question.question_passages.create(user: current_user, answer: params[:answer])

      check_answer(@question_passage)
      render json: { user_answer: @question_passage.answer, real_answer: @question_passage.question.answer.body, id: @question_passage.question.id }
    end
  end

  private

  def check_answer(question_passage)
    if question.answer.body == question_passage.answer
      recount_the_points
    end
  end

  def recount_the_points
    current_points = question.points(current_user)
    question.test_passage(current_user).update(points: current_points + 1)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end
end
