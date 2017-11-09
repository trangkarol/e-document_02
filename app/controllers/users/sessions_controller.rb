class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  layout "user"

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # user = User.find_by email: params[:user][:email].downcase

    # if user && user.authenticated?(:password, params[:user][:password])
    #   log_in user
    #    binding.pry
    #   # params[:user][:remember_me] == Settings.user.remember_me ? remember(user) : forget(user)
    #   flash[:success] = t "user.login_success"
    #   redirect_to root_path
    # else
    #   flash[:danger] = t "user.login_fail"
    #   render :new
    # end
    super do |resource|
      session[:history] = []
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
