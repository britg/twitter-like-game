class Api::V1::PlayersController < ApplicationController

  def show
    render json: current_player||Player.new.is_current_player!
  end

  def create
    create_player
    head 201
  end

  protected

end