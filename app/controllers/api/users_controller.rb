class Api::UsersController < Api::BaseController
  doorkeeper_for :all
  before_filter :find_user, except: [:index]
  around_filter :render_error, except: [:index]

  def index
    @users = User.all
  end

  def show
  end
end
