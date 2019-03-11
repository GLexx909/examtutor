class PostsController < ApplicationController
  authorize_resource

  def tutor_index
    @posts = Post.all
  end
end
