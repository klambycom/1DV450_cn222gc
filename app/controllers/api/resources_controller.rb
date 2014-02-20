class Api::ResourcesController < Api::BaseController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_resource, except: [:index, :create]
  around_filter :render_error, except: [:index]
  before_filter :filter_result

  def index
    @resources = Resource.all.offset(params[:offset] || 0).limit(params[:limit] || 10)
  end

  def show
  end

  def create
    @resource = Resource.new
    @resource.name = resource_params[:name]
    @resource.url = resource_params[:url]
    @resource.description = resource_params[:description]
    @resource.resource_type_id = ResourceType.find_by_uuid(resource_params[:resource_type_id]).id
    @resource.license_id = License.find_by_uuid(resource_params[:license_id]).id
    @resource.user_id = current_resource_owner_user.id
    @resource.save!
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
    helper_method :show_data_for?

    def show_data_for? field
      @only.empty? || @only.include?(field)
    end

    def resource_params
      params.permit(:resource_type_id, :license_id, :user_id, :name, :url, :description)
    end

    def filter_result
      @only = params[:only] && params[:only].split(',') || []
    end
end
