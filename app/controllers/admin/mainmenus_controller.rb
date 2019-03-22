class Admin::MainmenusController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: OneTimePassword

  def index
  end
end
