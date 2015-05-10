class Api::V1::LandmarksController < ApplicationController

  def index
    @map = PlayerMapService.new(current_player).map
    render json: @map, root: "map"
  end
end
