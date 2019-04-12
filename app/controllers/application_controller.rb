class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.js { render json: exception.message, status: :forbidden }
      format.json { render json: exception.message, status: :forbidden }
    end
  end

  def default_url_options
    { locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
  end

  protected

  helper_method :admin
  helper_method :notifications

  def set_locale
    I18n.locale = I18n.locale_available?(params[:locale]) ? params[:locale] : I18n.default_locale
  end

  def admin
    User.find_by(admin: true)
  end

  def notifications
    Notification.where(status: false, abonent: current_user).or(Notification.where(status: false, abonent: nil)).order(created_at: :desc)
  end
end
