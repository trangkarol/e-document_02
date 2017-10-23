class SessionsController < ApplicationController
  layout "user"

  def new
    @user = User.new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.user.remember_me ? remember(user) : forget(user)
      flash[:success] = t "user.login_success"
    else
      flash[:danger] = t "user.login_fail"
      render :new
    end
  end
end
