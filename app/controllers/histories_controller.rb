class HistoriesController < ApplicationController
  before_action :load_user_url, only: [:index]
  
  def index
    @list_histories = @user.list_history_docuement.paginate(page: params[:page], per_page: Settings.paginate_number)
    list_friend_request
    list_friends_accept
  end
end
