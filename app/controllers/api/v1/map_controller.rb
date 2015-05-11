class Api::V1::MapController < ApplicationController

  def index
    render_map
  end

  def update
    location_state = current_player.location_states.slug(params[:id])
    destination = location_state.location
    loc_proc = LocationProcessor.new(current_player, destination)

    loc_proc.already_at_location? or loc_proc.enter
    render json: {}
  end

  protected

  def render_map
    @map = PlayerMapService.new(current_player).map
    render json: @map, root: "map"
  end

end
