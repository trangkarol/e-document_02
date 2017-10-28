class DocumentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :load_document, only: [:show, :destroy]
  before_action :load_user_url, only: [:new, :create, :index, :destroy]

  def index
    @list_document = @user.documents.paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def show; end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build document_params
    if @document.save
      flash[:success] = t "messages.register_success"
      redirect_to user_documents_path(current_user)
    else
      render :new
    end
  end

  def edit; end

  def destroy
    if @document.destroy
      flash[:success] = t "document.delete_success"
    else
      flash[:danger] = t "document.delete_fail"
    end
    redirect_to user_documents_path(current_user)
  end

  private

  def document_params
    params.require(:document).permit :name, :image, :description, :file
  end

  def load_document
    @document = Document.includes(:owner).find_by_id params[:id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to user_documents_path(current_user)
  end
end
