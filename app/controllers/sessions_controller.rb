class SessionsController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back_or user
    else
      redirect_to root_path, notice: "Felaktiga uppgifter"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url, notice: "Utloggad"
  end
end
