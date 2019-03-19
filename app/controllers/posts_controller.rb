class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:guests_index]
  before_action :post, only: [:index, :tutor_index, :own_index, :guests_index, :show]

  authorize_resource

  def index
    @posts = Post.all
  end

  def tutor_index
    @posts = Post.of_admin
  end

  def own_index
    @posts = Post.of_user(current_user)
  end

  def guests_index
    @posts = Post.for_guests
  end

  def create
    if can?(:create, Post)
      @post = current_user.posts.create(post_params)
    else
      head :forbidden
    end
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
    @post ||= params[:id] ? Post.find(params[:id]) : current_user&.posts&.new
  end

  def post_params
    params.require(:post).permit(:title, :body, :for_guests)
  end
end
