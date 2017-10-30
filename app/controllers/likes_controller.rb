class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :load_document, only: [:create]
  before_action :check_likes_exit, only: [:create]

  def create
    @like.empty? ? like : unlike
  end

  private

  def load_document
    @document = Document.includes(:owner).find_by_id params[:document_id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to user_documents_path(current_user)
  end

  def check_likes_exit
    @like = Like.check_exit current_user.id, params[:document_id]
  end

  def like
    if @document.likes << Like.new(user_id: current_user.id)
      @document.update_number_of_like Settings.like.flag_like
    end
    redirect_to user_document_path(@document.owner.id, @document)
  end

  def unlike
    unless @like.destroy
      @document.update_number_of_like Settings.like.flag_unlike
    end
    redirect_to user_document_path(@document.owner.id, @document)
  end
end
