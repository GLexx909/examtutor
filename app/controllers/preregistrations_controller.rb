class PreregistrationsController < ApplicationController

  skip_authorization_check

  def new
  end

  def create
    email = params[:email]
    password = Devise.friendly_token[0, 20]
    @user = User.new(email: email, password: password, password_confirmation: password, first_name: 'temporary', last_name: 'temporary')

    if @user.save
      cookies[:pre_email] = email
      redirect_to user_session_path, notice: 'Вам отправленно письмо на почту для подтверждения авторизации'
    end
  end
end
