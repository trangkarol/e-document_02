class DocumentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

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

  private

  def document_params
    params.require(:document).permit :name, :image, :description, :file
  end
end
