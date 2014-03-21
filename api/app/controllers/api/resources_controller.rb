class Api::ResourcesController < Api::BaseController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_resource, except: [:index, :create]
  around_filter :render_error, except: [:index]
  before_filter :filter_result

  def index
    r = Resource.search(params[:query || ""])

    if params[:category]
      r = r.where(resource_type_id: ResourceType.find_by_uuid(params[:category]).id)
    end

    if params[:license]
      r = r.where(license_id: License.find_by_uuid(params[:license]).id)
    end

    @offset = params[:offset] || 0
    @limit = params[:limit] || 10
    @length = r.length

    @resources = r.offset(@offset).limit(@limit)
  end

  def show
  end

  def create
    @resource = Resource.create! do |r|
      r.name = resource_params[:name]
      r.url = resource_params[:url]
      r.description = resource_params[:description]
      r.resource_type_id = resource_params[:resource_type_id]
      r.license_id = resource_params[:license_id]
      r.user_id = current_resource_owner_user.id
      r.tags = resource_params[:tags]
    end

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
      params.permit(:resource_type_id, :license_id, :user_id, :name, :url, :description, :tags)
    end

    def filter_result
      @only = params[:only] && params[:only].split(',') || []
    end
end
