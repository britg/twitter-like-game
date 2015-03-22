class Api::V1::ActionsController < ApplicationController

  def create
    handler = ActionHandler.new(current_player, action_params[:event_id], action_params[:key])
    event = handler.perform_action!
    render json: event
  end

  protected

  def action_params
    params.require(:action).permit(:key, :event_id)
  end

end
