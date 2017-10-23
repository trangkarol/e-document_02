class HomePagesController < ApplicationController
  def index
    @documents = Document.includes(:owner).paginate page: params[:page]
  end
end
