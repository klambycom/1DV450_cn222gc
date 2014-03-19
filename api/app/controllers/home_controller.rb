class HomeController < ApplicationController
  def index
    @resources = Resource.all
  end

  def callback
    raise env["omniauth.auth"].to_yaml
  end
end
