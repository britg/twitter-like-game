class Api::V1::PlayersController < ApplicationController

  def show
    render json: current_player
  end

end
