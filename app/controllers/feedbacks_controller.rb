class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @feedbacks = Feedback.order(updated_at: :desc, created_at: :desc)
  end

  def create
    if !current_user.feedback
      @feedback = Feedback.new(feedback_params)
      @feedback.user = current_user
      @feedback.save
      Services::SendNotificationService.new('Создан новый отзыв', feedbacks_path, User.where(admin: true), current_user, type: 'feedback').send
    end
  end

  def edit
    feedback
  end

  def update
    feedback.update(feedback_params) if can?(:update, feedback)
    Services::SendNotificationService.new('Учеником обновлён отзыв', feedbacks_path, User.where(admin: true), current_user, type: 'feedback').send
  end

  def destroy
    feedback.destroy if can?(:destroy, feedback)
  end

  private

  def feedback
    @feedback ||= Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:body, :moderation, :approved)
  end
end
