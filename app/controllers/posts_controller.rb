class PostsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def tutor_index
    @posts = Post.all
  end

  def create
    post
  end

  private

  def post
    @post ||= params[:id] ? Post.find(params[:id]) : Post.new(post_params)
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
