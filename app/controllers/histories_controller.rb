class HistoriesController < ApplicationController
  before_action :load_user_url, only: [:index]
  before_action :list_friend_request, only: [:index]
  before_action :list_friends_accept, only: [:index]
  before_action :list_document_history, only: [:index]

  def index
    @list_histories = @user.list_history_docuement
                           .paginate(page: params[:page], per_page: Settings.paginate_number)
  end
end
