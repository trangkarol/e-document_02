module UsersHelper
  def load_user_url
    @user = User.find_by_id params[:user_id]
    return if @user
    flash[:danger] = t "user.user_not_found"
    redirect_to root_path
  end

  def session_history document
    if !session[:history].include? document.id
      session[:history].push(document.id)
    end
  end

  def check_download_user?
    current_user.check_download?
  end
end
