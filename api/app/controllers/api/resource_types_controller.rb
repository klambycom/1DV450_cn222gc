class Api::ResourceTypesController < Api::BaseController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_resource_type, except: [:index, :create]
  around_filter :render_error, except: [:index]

  def index
    @resourceTypes = ResourceType.all.offset(params[:offset] || 0).limit(params[:limit] || 10)
  end

  def show
  end

  def create
    if current_resource_owner_user.admin?
      @resourceType = ResourceType.create! resource_type_params
      render 'api/resource_types/show'
    else
      render 'api/errors/403', status: 403
    end
  end

  def update
    if current_resource_owner_user.admin?
      @resourceType.update_attributes! resource_type_params
      render 'api/resource_types/show'
    else
      render 'api/errors/403', status: 403
    end
  end

  def destroy
    if current_resource_owner_user.admin?
      @resourceType.destroy!
      render 'api/resource_types/show'
    else
      render 'api/errors/403', status: 403
    end
  end

  private

    def resource_type_params
      params.permit(:name)
    end
end
