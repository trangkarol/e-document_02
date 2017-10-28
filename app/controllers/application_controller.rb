class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include UsersHelper
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "user.please_log_in"
    redirect_to login_url
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end
