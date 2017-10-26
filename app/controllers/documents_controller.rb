class DocumentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :load_document, only: [:show, :destroy]

  def show; end

  def new
    @document = Document.new
    html = render_to_string "documents/_document_form", locals: {button_text: t("document.create")}, layout: false
    respond_to do |format|
      format.html{render text: html}
      format.json{render json: {html: html}}
    end
  end

  def create
    @document = current_user.documents.build document_params
    @document.save
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def destroy
    if @document.destroy
      flash[:success] = t "document.delete_success"
    else
      flash[:danger] = t "document.delete_fail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def document_params
    params.require(:document).permit :name, :image, :description, :file
  end

  def load_document
    @document = Document.includes(:owner).find_by_id params[:id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to root_path
  end
end
