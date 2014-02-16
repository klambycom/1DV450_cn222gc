class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to @user, success: "Välkommen användare!"
    else
      render 'new'
    end
  end

  def login
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:userid] = user.id
      redirect_to user
    else
      redirect_to root_path, notice: "Felaktiga uppgifter"
    end
  end

  def logout
    session[:userid] = nil
    redirect_to root_url, notice: "Utloggad"
  end

  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end
