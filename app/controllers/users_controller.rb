class UsersController < ApplicationController
  before_action :load_user, only: [:update, :edit, :show]

  def show; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.includes(:documents, :friends).find_by_id params[:id]
    return if @user
    flash[:danger] = t "user.user_not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :phone, :address, :birthday, :avatar
  end
end
