class ProfilesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource class: User

  def index
    @users = User.not_admin
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path if @user.admin?
  end
end
