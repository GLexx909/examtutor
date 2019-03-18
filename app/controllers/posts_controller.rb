class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :post, only: [:index, :tutor_index, :own_index, :show]

  authorize_resource

  def index
    @posts = Post.order(created_at: :desc)
  end

  def tutor_index
    @posts = Post.order(created_at: :desc).of_admin
  end

  def own_index
    @posts = Post.order(created_at: :desc).of_user(current_user)
  end

  def create
    @post = current_user.posts.create(post_params)
  end

  def show
  end

  def update
    if can?(:update, post)
      post.update(post_params)
    else
      head 403
    end
  end

  def destroy
    if can?(:destroy, post)
      post.destroy
    else
      head 403
    end
  end

  private

  def post
    @post ||= params[:id] ? Post.find(params[:id]) : current_user.posts.new
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
