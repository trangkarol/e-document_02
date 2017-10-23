module SessionsHelper
  # Set session for user
  def log_in user
    session[:user_id] = user.id
  end

  # Current user
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by_id session[:user_id]
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by_id user_id
      if user && user.authenticate(:remember, cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  # Check user is logged in
  def logged_in?
    current_user.present?
  end

  def forget _user
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end
>>>>>>>  User profile
end
