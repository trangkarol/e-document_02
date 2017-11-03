class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update, :edit, :show]
  before_action :load_user, only: [:update, :edit, :show, :document]

  def show; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "user.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def search
    search_member
    respond_to do |format|
      format.html{head :no_content}
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit :phone, :address, :birthday, :avatar
  end

  def load_user
    @user = User.find_by_id params[:id]
    return if @user
    flash[:danger] = t "user.user_not_found"
    redirect_to root_path
  end
end
