class HistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :load_user_url, only: [:create, :update, :index]
  def index
    @list_histories = @user.list_history_docuement
      .paginate(page: params[:page], per_page: Settings.paginate_number)
    respond_to do |format|
      format.html{head :no_content}
      format.js
    end
  end
end
