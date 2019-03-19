class ProfilesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource class: User

  def index
    @users = User.not_admin
  end
end
