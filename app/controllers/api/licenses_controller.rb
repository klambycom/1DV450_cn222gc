class Api::LicensesController < Api::BaseController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_license, except: [:index, :create]
  around_filter :render_error, except: [:index]

  def index
    @licenses = License.all.offset(params[:offset] || 0).limit(params[:limit] || 10)
  end

  def show
  end

  def create
    if current_resource_owner_user.admin?
      @license = License.create! license_params
      render 'api/licenses/show'
    else
      render 'api/errors/403', status: 403
    end
  end

  def update
    if current_resource_owner_user.admin?
      @license.update_attributes! license_params
      render 'api/licenses/show'
    else
      render 'api/errors/403', status: 403
    end
  end

  def destroy
    if current_resource_owner_user.admin?
      @license.destroy!
      render 'api/licenses/show'
    else
      render 'api/errors/403', status: 403
    end
  end

  private

    def license_params
      params.permit(:name, :description, :url)
    end
end
