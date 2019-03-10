class InitialsController < ApplicationController
  skip_authorization_check

  def index
    @user = User.new
  end

  def new
  end

  def create
  end
end
