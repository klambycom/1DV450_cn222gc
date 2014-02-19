class Developers::DashboardController < Developers::BaseController
  def index
  end

  def new
    @application = Doorkeeper::Application.new
  end

  def create
    @application = Doorkeeper::Application.new application_params
    @application.owner = current_user if Doorkeeper.configuration.confirm_application_owner?
    if @application.save
      redirect_to developers_dashboard_url(@application)
    else
      render :new
    end
  end

  def show
    @application = Doorkeeper::Application.find params[:id]
  end

  private

    def application_params
      params.require(:application).permit(:name, :redirect_uri)
    end
end
