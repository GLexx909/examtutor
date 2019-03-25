class AnswersController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
