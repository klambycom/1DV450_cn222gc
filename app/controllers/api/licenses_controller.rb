class Api::LicensesController < ApplicationController
  def index
    @licenses = License.all
  end

  def show
    @license = License.find params[:id]
  end

  def create
  end

  def update
  end

  def destroy
  end
end
