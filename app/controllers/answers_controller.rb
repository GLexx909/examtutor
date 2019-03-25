class AnswersController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def edit
    answer
  end

  def update
    answer.update(answer_params)
  end

  def destroy
    answer.destroy
  end

  private

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
