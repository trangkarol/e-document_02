class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_document, only: [:new, :create, :update, :destroy, :download, :show]
  before_action :load_user_url, only: [:new, :create, :index, :destroy]
  before_action :list_friend_request, only: [:show, :new, :edit, :update]
  before_action :list_friends_accept, only: [:show, :new, :edit, :update]
  before_action :list_document_history, expect: [:index, :download]
  before_action :check_exit_history, only: [:download]

  def index
    @list_document = @user.documents
      .paginate(page: params[:page], per_page: Settings.paginate_number)
    respond_to do |format|
      format.html{head :no_content}
      format.js
    end
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
    Document.transaction do
      current_user.update_number_upload
      current_user.update_total_coins Settings.user.minus_total_coin
      save_document
    end
    rescue Document::RecordInvalid => exception
    render :new
  end

  def search
    search_document
    respond_to do |format|
      format.html{head :no_content}
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
    redirect_to root_path
  end

  def download
    Document.transaction do
      if check_download_user?
        current_user.update_number_download
        @document.update_number_download
        create_history Settings.history.action_download
        send_file @document.file.path,
          filename: @document.file.file.filename
        flash[:success] = t "document.download_success"
      else
        flash[:danger] = t "document.download_fail"
      end
    end
    rescue Document::RecordInvalid => exception
  end

  def statictis
    @list_statics = @document.histories.list_histories_statistic(Settings.history.action_download)
      .paginate(page: params[:page], per_page: Settings.paginate_number)
    respond_to do |format|
      format.html{head :no_content}
      format.js
    end
  end

  private

  def document_params
    params.require(:document).permit :name, :image, :description, :file, :category_id
  end

  def load_document
    params[:id] ||= params[:document_id]
    @document = Document.includes(:owner, :likes, :category).find_by_id params[:id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to root_path
  end

  def create_history name_action
    if !@history.any?
      @history = current_user.histories.build history_params(name_action)
      unless @history.save
        flash[:danger] = t "document.delete_fail"
        redirect_to user_documents_path(current_user)
      end
    else
      @history.first.update_number
    end
  end

  def save_document
    unless @document.save
      flash[:success] = t "document.upload_success"
      redirect_to edit_user_document_path(current_user.id, @document)
    end
  end

  def check_exit_history
    @history = History.check_exit @document.id, current_user.id, Settings.history.action_download
  end

  def history_params name_action
    {document_id: @document.id, name_action: name_action}
  end
end
