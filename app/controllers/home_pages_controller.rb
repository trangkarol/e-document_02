class HomePagesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :list_friend_request, only: [:index, :search]
  before_action :list_friends_accept, only: [:index, :search]
  before_action :list_document_history, only: [:index, :search]

  def index
    list_documents
  end

  def search
    search_document
    search_member
  end

  private

  def list_documents
    @documents = Document.includes(:owner).paginate(page: params[:page], per_page: Settings.paginate_number)
  end
end
