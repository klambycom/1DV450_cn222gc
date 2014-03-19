class HomeController < ApplicationController
  def index
  end

  def callback
    credentials = env["omniauth.auth"]["credentials"]

    cookies[:access_token] = {
      value: credentials["token"],
      expires: Time.at(credentials["expires_at"])
    } 

    redirect_to root_url
  end
end
