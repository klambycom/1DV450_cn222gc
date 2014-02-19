class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    helper_method :current_user, :logged_in?, :admin?

    def current_user
      @current_user ||= User.find session[:user_id] if session[:user_id]
    end

    def logged_in?
      current_user.present?
    end

    def admin?
      current_user.present? && current_user.admin?
    end

    def require_login
      if current_user.nil?
        store_location
        redirect_to login_url(subdomain: false)
      end
    end

    def require_admin
      unless current_user.admin?
        store_location
        redirect_to login_url(subdomain: false)
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
