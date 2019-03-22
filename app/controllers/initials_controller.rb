class InitialsController < ApplicationController
  skip_authorization_check
  layout 'initial', only: [:index]

  def index
    @user = User.new
  end

  def create
    password = params[:preregistration_pass]
    one_time_password = OneTimePassword.find_by_pass_word(password)

    if one_time_password
      session[:pre_password] = password
      one_time_password.destroy

      redirect_to new_user_registration_path, notice: 'Успешно!'
    else
      redirect_to root_path, alert: 'Доступ закрыт'
    end
  end
end
