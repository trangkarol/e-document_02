class DocumentsController < ApplicationController
  def new
    @document = Document.new
    html = render_to_string "documents/_document_form", locals: {button_text: t("document.create")}, layout: false
    respond_to do |format|
      format.html {render text: html}
      format.json {render json: {html: html}}
    end
  end

  def create
    @document = current_user.documents.build document_params
    if @document.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def edit; end

  private

  def document_params
    params.require(:document).permit :name, :image, :description, :file
  end
end
