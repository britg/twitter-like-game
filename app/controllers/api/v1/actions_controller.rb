class Api::V1::ActionsController < ApplicationController

  before_filter :require_player

  def create
    current_player.input action_params[:key]
    render json: current_player,
           serializer: StorySerializer,
           root: nil
  end

  protected

  def action_params
    params.require(:player_action).permit(:key)
  end

end
