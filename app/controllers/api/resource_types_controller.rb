class Api::ResourceTypesController < Api::BaseController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_resource_type, except: [:index, :create]
  around_filter :render_error, except: [:index]

  def index
    @resourceTypes = ResourceType.all
  end

  def show
  end

  def create
    @resourceType = ResourceType.create! resource_type_params
    render 'api/resource_types/show'
  end

  def update
    @resourceType.update_attributes! resource_type_params
    render 'api/resource_types/show'
  end

  def destroy
    @resourceType.destroy!
    render 'api/resource_types/show'
  end

  private

    def resource_type_params
      params.permit(:name)
    end
end
