class HomePagesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    list_documents
    list_friend_request
    list_friends_accept
  end

  private

  def list_documents
    @documents = Document.includes(:owner).paginate(page: params[:page], per_page: Settings.document.paginate_number)
  end
end
