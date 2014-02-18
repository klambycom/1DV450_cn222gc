class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def current_user
      @current_user ||= User.find session[:user_id] if session[:user_id]
    end

    def require_login
      if current_user.nil?
        store_location
        redirect_to root_url(subdomain: false)
      end
    end

    def store_location
      session[:return_to] = request.url if request.get?
    end

    def redirect_back_or default
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
end
