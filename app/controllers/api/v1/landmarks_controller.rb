class Api::V1::LandmarksController < ApplicationController

  def index
    render json: current_player.location_states, root: "locations"
  end
end
