class Api::V1::PlayerLocationsController < ApplicationController

  before_filter :ensure_player

  def show
    render json: service.player_location
  end

  protected

  def ensure_player
    create_player unless current_player.present?
  end

  def create_player
    @current_player = Player.create
    cookies.permanent.signed[:player_id] = @current_player.id.to_s
  end

  def slug_param
    params[:id]
  end

  def location
    @location ||= Location.where(slug: slug_param).first
  end

  def service
    @service ||= PlayerLocationService.new(current_player, location)
  end

end
