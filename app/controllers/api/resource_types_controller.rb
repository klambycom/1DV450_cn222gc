class Api::ResourceTypesController < ApplicationController
  def index
    @resourceTypes = ResourceType.all
  end

  def show
    @resourceType = ResourceType.find params[:id]
  end

  def create
  end

  def update
  end

  def destroy
  end
end
