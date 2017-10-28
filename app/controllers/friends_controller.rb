class FriendsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @firend = current_user.friends.build friend_params
    if @firend.save
      flash[:success] = t "firend.create_success"
    else
      flash[:danger] = t "firend.create_fail"
    end
    redirect_to root_url
  end

  private

  def friend_params
    params.permit :friend_id
  end
end
