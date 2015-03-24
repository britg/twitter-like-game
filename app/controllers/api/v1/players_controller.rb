class Api::V1::PlayersController < ApplicationController

  def show
    # render json: current_player
    render_current_player
  end

  def create
    create_player
    render_current_player
  end

  def update
    handler = ActionHandler.new(current_player, selection_params[:selected_action_key])
    handler.proceed!
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
  end

  def selection_params
    params.require(:player).permit(:selected_action_key)
  end

end