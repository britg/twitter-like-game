class Api::V1::PlayersController < ApplicationController

  def show
    # render json: current_player
    render_current_player
  end

  def create
    create_player
    render_current_player
  end

  protected

  def render_current_player
    render json: current_player,
           serializer: CurrentPlayerSerializer,
           root: "player"
  end

  def create_player
    @current_player = PlayerCreationService.new.create
    # cookies.permanent.signed[:player_id] = @current_player.id.to_s
  end


end