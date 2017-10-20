class UsersController < ApplicationController
  layout "user"
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.valid? && upload_file(params[:user][:avatar]) && @user.save
      flash[:success] = t "messages.register_success"
    else
      render :new
    end
  end

  def edit; end

  def update; end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :birthday
  end
end
