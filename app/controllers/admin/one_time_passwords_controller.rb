class Admin::OneTimePasswordsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: OneTimePassword

  def new
    @one_time_password = OneTimePassword.new
  end

  def create
    @one_time_password = OneTimePassword.create(one_time_password_params)
  end

  private

  def one_time_password_params
    params.require(:one_time_password).permit(:pass_word)
  end
end
