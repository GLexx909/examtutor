class InitialsController < ApplicationController
  skip_authorization_check
  layout 'initial', only: [:index]

  def index
    @user = User.new
  end

  def get_availability
    if User.find_by(id: identify_id, last_name: identify_name)
      cookies[:parent] = identify_id
      redirect_to characteristic_path(identify_id)
    else
      flash[:alert] = 'Идентификатор набран неверно'
      redirect_to root_path
    end
  end

  def create
    password = params[:preregistration_pass]
    one_time_password = OneTimePassword.find_by_pass_word(password)

    if one_time_password
      cookies[:pre_password] = password
      one_time_password.destroy

      redirect_to new_user_registration_path, notice: 'Успешно!'
    else
      redirect_to root_path, alert: 'Доступ закрыт'
    end
  end

  private

  def identify_full
    params[:identify_name][0]
  end

  def identify_id
    identify_full.split('-').last
  end

  def identify_name
    identify_full.split('-').first
  end
end
