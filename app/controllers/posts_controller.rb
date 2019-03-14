class PostsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @posts = Post.order(created_at: :desc)
    @post = Post.new
  end

  def tutor_index
    @posts = Post.order(created_at: :desc).of_admin
    @post = Post.new
  end

  def create
    post.save
  end

  def show
    post
  end

  def destroy
    post.destroy
    post
  end

  private

  def post
    @post ||= params[:id] ? Post.find(params[:id]) : current_user.posts.new(post_params)
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
