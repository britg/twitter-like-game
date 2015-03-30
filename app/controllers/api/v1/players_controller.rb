class Api::V1::PlayersController < ApplicationController

  def show
    render_current_player
  end

  def create
    create_player
    render_current_player
  end

  def update
    action_key = selection_params[:selected_action_key]
    handler = ActionHandler.new(current_player)
    handler.proceed! action_key
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