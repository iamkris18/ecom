class ApplicationController < ActionController::Base
    helper_method :current_user, :authenticate_user!

    private
  
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def authenticate_user!
      redirect_to login_path unless current_user
    end
end
