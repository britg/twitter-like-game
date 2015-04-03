class HomeController < ApplicationController
  def index
    @new_player = Player.new
    redirect_to player_location_path and return \
      if current_player.present?
  end
end
