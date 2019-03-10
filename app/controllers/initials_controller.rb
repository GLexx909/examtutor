class InitialsController < ApplicationController
  skip_authorization_check

  def index
    @user = User.new
  end

  def new
  end

  def create
    # password = params[:preregistration_pass]
    #
    # if Onetimepasswords.include?(password)
    # #
    # else
    # #
    # end
  end
end
