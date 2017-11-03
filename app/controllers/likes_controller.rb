class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :index]
  before_action :load_document, only: [:create, :index]
  before_action :check_likes_exit, only: [:create]

  def create
    @like.any? ? unlike : like
    redirect_back(fallback_location: root_path)
  end

  def index
    @list_user_liked = @document.likes.list_user
      .paginate(page: params[:page], per_page: Settings.paginate_number)
    html = render_to_string "likes/_list_member", layout: false
    render json: {html: html}
  end

  private

  def load_document
    @document = Document.includes(:owner).find_by_id params[:document_id]
    return if @document
    flash[:danger] = t "document.document_not_found"
    redirect_to user_documents_path(current_user)
  end

  def check_likes_exit
    @like = Like.check_exit(current_user.id, params[:document_id])
  end

  def like
    if @document.likes << Like.new(user_id: current_user.id)
      @document.update_number_of_like Settings.like.flag_like
    end
  end

  def unlike
    if @like.first.destroy
      @document.update_number_of_like Settings.like.flag_unlike
    end
  end
end
