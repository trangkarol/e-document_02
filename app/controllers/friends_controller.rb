class FriendsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :load_user_url, except: [:new, :update]
  before_action :load_friend, only: [:update, :destroy]

  def index
    @list_friends = @user.list_friends
  end

  def create
    @friend = current_user.friends.build friend_params
    if @friend.save
      flash[:success] = t "friend.create_success"
    else
      flash[:danger] = t "friend.create_fail"
    end
    redirect_to root_url
  end

  def update
    @friend.accpet_request
    redirect_to root_url
  end

  def destroy
    if @friend.destroy
      flash[:success] = t "friend.unfriend_success"
    else
      flash[:danger] = t "friend.unfriend_fail"
    end
    redirect_to user_friends_path(current_user)
  end

  private

  def friend_params
    params.permit :friend_id
  end

  def load_friend
    @friend = Friend.find_by_id params[:id]
    return if @friend
    flash[:danger] = t "friend.friend_not_found"
    redirect_to user_friends_path(current_user)
  end
end
