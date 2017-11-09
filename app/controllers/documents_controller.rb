class DocumentsController < ApplicationController
  before_action :logged_in_user, except: [:index]
  before_action :load_document, only: [:show, :destroy, :edit]
  before_action :load_user_url, only: [:new, :create, :index, :destroy]
  before_action :list_friend_request, only: [:show, :edit, :update]
  before_action :list_friends_accept, only: [:show, :edit, :update]
  before_action :list_category, only: [:new, :update]
  before_action :list_document_history, only: [:show, :edit, :update]

  def index
    @list_document = @user.documents.paginate(page: params[:page], per_page: Settings.paginate_number)
  end

  def show
    session_history @document
  end

  def edit; end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build document_params
    if @document.save
      current_user.update_number_upload
      current_user.update_total_coins Settings.user.minus_total_coin
      # add to history
      create_history Settings.history.action_upload
      flash[:success] = t "document.upload_success"
      redirect_to user_documents_path(current_user)
    else
      render :new
    end
  end

  def search
    search_document
    respond_to do |format|
      format.html{}
      format.js
    end
  end

  def update; end

  def destroy
    if @document.destroy
      flash[:success] = t "document.delete_success"
    else
      flash[:danger] = t "document.delete_fail"
    end
    redirect_to user_documents_path(current_user)
  end

  def download
    if check_download_user?
      current_user.update_number_download
      @document.update_number_download
      create_history Settings.history.action_download
      send_file @document.file.path,
        filename: @document.file.file.filename

      flash[:success] = t "document.download_success"
    else
      flash[:danger] = t "document.download_fail"
      redirect_to user_document_path(@document.owner.id, @document)
    end
  end

  private

  def document_params
    params.require(:document).permit :name, :image, :description, :file, :category_id
  end

  def load_document
    params[:id] ||= params[:format]
    @document = Document.includes(:owner, :likes, :category).find_by_id params[:id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to user_documents_path(current_user)
  end

  def create_history name_action
    params_history = {document_id: @document.id, name_action: name_action}
    history = current_user.histories.build params_history
    return if history.save
    flash[:danger] = t "document.delete_fail"
    redirect_to user_documents_path(current_user)
  end

  def list_category
    @categories = Category.all
  end
end
