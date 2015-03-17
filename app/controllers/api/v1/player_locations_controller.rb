class Api::V1::PlayerLocationsController < ApplicationController


  def show
    render json: current_player.current_location
  end

  protected

  def slug_param
    params[:id]
  end

end
