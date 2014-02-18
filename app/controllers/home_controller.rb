class HomeController < ApplicationController
  def index
    session[:return_to] = params[:return_to] if params[:return_to]
  end
end
