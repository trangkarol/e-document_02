class HomePagesController < ApplicationController
  def index
    @documents = Document.includes(:owner).paginate(page: params[:page], per_page: Settings.paginate_number)
    @friend_request = User.paginate(page: params[:page], per_page: Settings.paginate_number)
  end
end
