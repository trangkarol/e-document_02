class HomePagesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    list_documents
    list_friend_request
    list_friends_accept
  end

  private

  def list_friend_request
    friend_ids = current_user.friends.pluck(:friend_id)
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

  def list_documents
    @documents = Document.includes(:owner).paginate(page: params[:page], per_page: Settings.document.paginate_number)
  end
end
