class InitialsController < ApplicationController
  skip_authorization_check
  layout 'initial', only: [:index]

  def index
    @user = User.new
  end

  def create
    password = params[:preregistration_pass]

    if one_time_passwords.include?(password)
      session[:pre_password] = password
      redirect_to new_user_registration_path, notice: 'Успешно!'
    else
      redirect_to root_path, alert: 'Доступ закрыт'
    end
  end

  private

  def one_time_passwords
    OneTimePassword.pluck(:password)
  end
end
