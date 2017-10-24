class HomePagesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    list_documents
    list_friend_request
    list_friend_accepting
  end

  private

  def list_friend_request
    friend_ids = current_user.friends.pluck(:friend_id)
    @list_friend_request = User.friends_request(current_user.id, friend_ids)
                               .paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def list_friend_accepting
    @list_friend_accpeting = current_user.friends.list_friends.paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def list_documents
    @documents = Document.includes(:owner).paginate(page: params[:page], per_page: Settings.paginate_number)
  end
end
