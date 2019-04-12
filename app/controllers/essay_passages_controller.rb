class EssayPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :essay_passage, only: [:new, :show]

  authorize_resource

  def new
  end

  def show
  end

  def create
    @essay_passage = essay.essay_passages.new(essay_passage_params)
    @essay_passage.user = current_user
    @essay_passage.save unless essay.essay_passage(current_user)
    redirect_to essay_path(essay)
  end

  def update
    essay_passage.update(essay_passage_params)
  end

  def update_status
    essay_passage.update(status: true)
    Services::SendNotificationService.new('Ваше эссе проверено', essay_path(essay_passage.essay), essay_passage.user, current_user).send
    head :ok
  end

  private

  def essay_passage
    @essay_passage ||= params[:id] ? EssayPassage.find(params[:id]) : essay.essay_passages.new
  end

  def essay
    @essay ||= Essay.find(params[:essay_id])
  end

  def essay_passage_params
    params.require(:essay_passage).permit(:body)
  end
end
