class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to root_url
    else
      session[:return_to] = params[:return_to] if params[:return_to]
    end
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back_or user
    else
      redirect_to login_url, notice: "Felaktigt användarnamn eller lösenord"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end
