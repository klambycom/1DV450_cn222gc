class Developers::DashboardController < Developers::BaseController
  before_filter :find_application, except: [:admin, :index, :new, :create]
  before_action :require_login
  before_action :require_admin, only: :admin

  def admin
    @applications = Doorkeeper::Application.all
  end

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
    unless current_user_is_owner? || current_user.admin?
      flash[:error] = "Kunde inte hitta den valda applikationen"
      redirect_to developers_dashboard_index_url
    end
  end

  def edit
  end

  def update
    unless current_user_is_owner?
      if @application.update_attributes application_params
        redirect_to developers_dashboard_url(@application)
      else
        render :edit
      end
    end
  end

  def destroy
    if current_user_is_owner? || current_user.admin?
      flash[:notice] = "Applikationen \"#{@application.name}\" är borttagen." if @application.destroy
      redirect_to developers_dashboard_index_url
    end
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
