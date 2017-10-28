module UsersHelper
  def load_user_url
    @user = User.find_by_id params[:user_id]
    return if @user
    flash[:danger] = t "user.user_not_found"
    redirect_to root_path
  end
end
