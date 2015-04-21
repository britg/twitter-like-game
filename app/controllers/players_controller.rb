class PlayersController < ApplicationController
  def create
    @current_player = PlayerCreator.new.create
    cookies.permanent.signed[:continue_token] = @current_player.continue_token
    redirect_to game_path
  end
end
