class Api::UsersController < Api::BaseController
  doorkeeper_for :all, except: [:show]
  before_filter :restrict_access_with_token, except: [:index]

  before_filter :find_user, except: [:index]
  around_filter :render_error, except: [:index]

  def index
    @user = current_resource_owner_user
  end

  def show
  end
end
