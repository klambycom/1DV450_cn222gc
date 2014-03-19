class HomeController < ApplicationController
  def index
  end

  def callback
    raise env["omniauth.auth"].to_yaml
  end
end
