class PlayersController < ApplicationController
  def create
    @current_player = PlayerCreationService.new.create
    cookies.permanent.signed[:continue_token] = @current_player.continue_token
    redirect_to player_location_path
  end
end
