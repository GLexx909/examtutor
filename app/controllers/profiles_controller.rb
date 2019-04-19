class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :user, except: [:index]

  authorize_resource class: User

  def index
    @q = User.not_admin.ransack(params[:q])
    @users = @q.result.page(params[:page])
  end

  def show
    redirect_to root_path if cannot?(:manage, :all) && user.admin?
    user_posts
  end

  def edit
    redirect_to root_path if cannot?(:update, user)
  end

  def update
    redirect_to root_path if cannot?(:update, user)
    # user.update(user_params) if check_avatar_extension?
    user.update(user_params)
  end

  def destroy
    if can?(:destroy, user)
      user.destroy
    else
      head :forbidden
    end
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_posts
    @user_posts ||= user.posts.page(params[:page])
  end

  # def check_avatar_extension?
  #   return true unless params[:user][:avatar]
  #   %w(png jpg jpeg).each do |ext|
  #     return true if params[:user][:avatar].tempfile.path.split('.').last == ext
  #   end
  #   false
  # end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar)
  end
end
