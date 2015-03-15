class Api::V1::LocationsController < ApplicationController

  def show
    render json: Location.where(slug: slug_param).first
  end

  protected

  def slug_param
    params[:id]
  end
end
