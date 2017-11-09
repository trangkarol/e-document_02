class CommentsController < ApplicationController
  before_action :load_document, only: [:index, :create]
  before_action :logged_in_user, only: :create

  def index
    @comment = Comment.new
    @list_comment = @document.comments.paginate(page: params[:page], per_page: Settings.paginate_number)
    respond_to do |format|
      format.html{}
      format.js
    end
  end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      @document.update_number_of_comment
      html = render_to_string "comments/_comment", locals: {comment:@comment}, layout: false
      render json: {html: html, status: true }
    else
      render json: {status: true}
    end
  end

  private

  def load_document
    @document = Document.includes(:owner, :likes, :category).find_by_id params[:document_id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to user_documents_path(current_user)
  end

  def comment_params
    params.permit :content, :document_id
  end
end
