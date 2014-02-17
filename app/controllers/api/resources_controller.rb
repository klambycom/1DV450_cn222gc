class Api::ResourcesController < ApplicationController
  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find params[:id]
  end

  def create
  end

  def update
  end

  def destroy
  end
end
