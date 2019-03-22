class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :user, except: [:index]

  authorize_resource class: User

  def index
    @users = User.not_admin
  end

  def show
    redirect_to root_path if @user.admin?
  end

  def edit
    redirect_to root_path if cannot?(:update, @user)
  end

  def update
    redirect_to root_path if cannot?(:update, @user)
    @user.update(user_params)
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
