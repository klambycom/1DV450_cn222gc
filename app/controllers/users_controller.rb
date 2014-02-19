class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Välkommen användare!"
      redirect_back_or @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end
