class CharacteristicsController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @users = User.all
  end

  def show
    user
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
