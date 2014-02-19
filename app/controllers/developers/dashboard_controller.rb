class Developers::DashboardController < Developers::BaseController
  before_filter :find_application, except: [:index, :new, :create]
  before_action :require_login

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
    unless current_user_is_owner?
      flash[:error] = "Kunde inte hitta den valda applikationen"
      redirect_to developers_dashboard_index_url
    end
  end

  def edit
  end

  def update
    if @application.update_attributes application_params
      redirect_to developers_dashboard_url(@application)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Applikationen \"#{@application.name}\" är borttagen." if @application.destroy
    redirect_to developers_dashboard_index_url
  end

  private

    def find_application
      @application = Doorkeeper::Application.find params[:id]
    end

    def application_params
      params.require(:application).permit(:name, :redirect_uri)
    end

    def current_user_is_owner?
      @application.owner == current_user
    end
end
