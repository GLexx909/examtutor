class PostsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def tutor_index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end

  def create
    post.save
    redirect_to tutor_index_posts_path
  end

  def show
    post
  end

  def destroy
    post.destroy
    redirect_to tutor_index_posts_path
  end

  private

  def post
    @post ||= params[:id] ? Post.find(params[:id]) : current_user.posts.new(post_params)
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
