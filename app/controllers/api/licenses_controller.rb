class Api::LicensesController < ApiController
  before_filter :find_license, except: [:index, :create]
  around_filter :render_error, except: [:index]

  def index
    @licenses = License.all
  end

  def show
  end

  def create
    @license = License.create! license_params
    render 'api/licenses/show'
  end

  def update
    @license.update_attributes! license_params
    render 'api/licenses/show'
  end

  def destroy
    @license.destroy!
    render 'api/licenses/show'
  end

  private

    def license_params
      params.permit(:name, :description, :url)
    end
end
