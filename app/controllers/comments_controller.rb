class CommentsController < ApplicationController
  include Voted
  before_action :authenticate_user!, except: [:guests_index]

  authorize_resource

  def create
    comment.post = post
    comment.save
    Services::SendNotificationService.new("Комментарий к посту от #{current_user.full_name}",
                                          post_path(post), post.author, current_user, type: 'comment').send
  end

  def edit
    comment
  end

  def update
    comment.update(comment_params) if can?(:update, comment)
  end

  def destroy
    comment.destroy if can?(:destroy, comment)
  end

  private

  def comment
    @comment ||= params[:id] ? Comment.find(params[:id]) : current_user.comments.new(comment_params)
  end

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
