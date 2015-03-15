class Api::V1::PlayersController < ApplicationController

  def index
    render json: Player.where(id: params[:id]).first
  end

end