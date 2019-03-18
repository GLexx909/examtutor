class InitialsController < ApplicationController
  skip_authorization_check
  layout 'initial', only: [:index]

  def index
    @user = User.new
  end

  def create
    password = params[:preregistration_pass]

    if one_time_password(password)
      session[:pre_password] = password
      one_time_password(password).delete

      redirect_to new_user_registration_path, notice: 'Успешно!'
    else
      redirect_to root_path, alert: 'Доступ закрыт'
    end
  end

  private

  def one_time_password(password)
    OneTimePassword.find_by(pass_word: password)
  end
end
