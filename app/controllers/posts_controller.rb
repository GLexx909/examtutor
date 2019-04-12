class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:guests_index]
  before_action :post, only: [:index, :tutor_index, :own_index, :guests_index, :show]
  before_action :bread_crumbs, only: [:index, :tutor_index, :own_index]

  authorize_resource

  def index
    @posts = Post.all.page(params[:page])
  end

  def tutor_index
    @posts = Post.of_admin.page(params[:page])
  end

  def own_index
    @posts = Post.of_user(current_user).page(params[:page])
  end

  def guests_index
    @posts = Post.for_guests.page(params[:page])
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
    @post ||= params[:id] ? Post.find(params[:id]) : current_user&.posts&.new
  end

  def bread_crumbs
    add_breadcrumb "Все посты", :posts_path, :title => "Все посты"
    add_breadcrumb "Посты репетитора", :tutor_index_posts_path, :title => "Все посты репетитора"
    add_breadcrumb "Мои посты", :own_index_posts_path, :title => "Все мои посты"
  end

  def post_params
    params.require(:post).permit(:title, :body, :for_guests, files: [])
  end
end
