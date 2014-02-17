class Api::UsersController < ApiController
  before_filter :find_user, except: [:index]
  around_filter :render_error, except: [:index]

  def index
    @users = User.all
  end

  def show
  end
end
