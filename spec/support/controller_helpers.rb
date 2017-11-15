module ControllerHelpers
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create :user
    session[:history] = []
    sign_in user
  end
end

RSpec.configure do |config|
  config.include ControllerHelpers, :type => :controller
  config.include ControllerHelpers, :type => :view
end
