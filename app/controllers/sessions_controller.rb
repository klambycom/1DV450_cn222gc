class SessionsController < ApplicationController
  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:userid] = user.id
      redirect_to user
    else
      redirect_to root_path, notice: "Felaktiga uppgifter"
    end
  end

  def logout
    session[:userid] = nil
    redirect_to root_url, notice: "Utloggad"
  end
end
