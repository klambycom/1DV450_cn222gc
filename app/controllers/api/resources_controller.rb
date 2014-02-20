class Api::ResourcesController < ApiController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_resource, except: [:index, :create]
  around_filter :render_error, except: [:index]

  def index
    @resources = Resource.all
  end

  def show
  end

  def create
    @resource = Resource.create! resource_params
    render 'api/resources/show'
  end

  def update
    @resource.update_attributes! resource_params
    render 'api/resources/show'
  end

  def destroy
    @resource.destroy!
    render 'api/resources/show'
  end

  private

    def resource_params
      params.permit(:resource_type_id, :license_id, :user_id, :name, :url, :description)
    end
end
