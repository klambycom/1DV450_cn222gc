class Api::UsersController < Api::BaseController
  doorkeeper_for :all
  before_filter :find_user, except: [:index]
  around_filter :render_error, except: [:index]

  def index
    @users = User.all.offset(params[:offset] || 0).limit(params[:limit] || 10)
  end

  def show
  end
end
