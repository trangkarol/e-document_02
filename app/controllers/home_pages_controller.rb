class HomePagesController < ApplicationController
  def index
    @documents = Document.paginate page: params[:page]
  end
end
