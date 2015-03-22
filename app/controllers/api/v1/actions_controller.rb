class Api::V1::ActionsController < ApplicationController

  def create
    handler = ActionHandler.new(current_player, action_key)
    event = handler.perform_action!
    render json: event
  end

  protected

  def action_key
    parmas[:action_key]
  end

end
