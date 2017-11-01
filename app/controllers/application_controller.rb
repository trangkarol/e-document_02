class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_locale
  include UsersHelper
  # include SessionsHelper

  private

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def logged_in_user
    return if user_signed_in?
    flash[:danger] = t "user.please_log_in"
    redirect_to new_user_session_path
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def list_friend_request
    friend_ids = current_user.friends.pluck(:friend_id) + current_user.request.pluck(:user_id)
    if !friend_ids.empty?
      @list_friend_request = User.friends_request(current_user.id, friend_ids)
                                 .paginate(page: params[:page], per_page: Settings.paginate_number)
    else
      @list_friend_request = User.not_current_user(current_user.id)
                                 .paginate(page: params[:page], per_page: Settings.paginate_number)
    end
  end

  def list_friends_accept
    @list_friends_accept = Friend.friend_accept(current_user.id)
                                 .paginate(page: params[:page], per_page: Settings.paginate_number)
  end
  def search_document
    @result_documents = Document.search_document(params[:search])
                                .includes(:owner)
                                .paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def search_member
    @result_user = User.not_current_user(current_user.id).search_user(params[:search])
                       .paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def list_document_history
    @list_document_history = []
    if session[:history].any?
      @list_document_history = Document.where("id IN (?)", session[:history]).paginate(page: params[:page], per_page: Settings.paginate_number)
    end
  end
end
