class GameController < ApplicationController

  before_filter :redirect_to_player_location

  def index
    redirect_to root_path and return if !current_player.present?
    @player_json = CurrentPlayerSerializer.new(current_player).to_json(root: "player")
  end

end
