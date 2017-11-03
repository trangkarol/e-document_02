class StaticsController < ApplicationController
  before_action :logged_in_user, only: [:create, :update, :destroy]
  before_action :load_user_url, only: [:create, :update, :index]
  def index
    @list_statics =  Document.includes(:user)
      .paginate(page: params[:page], per_page: Settings.paginate_number)
    respond_to do |format|
      format.html{head :no_content}
      format.js
    end
  end
end
