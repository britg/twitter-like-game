class GameController < ApplicationController

  before_filter :ensure_player

  def index
    @player_json = PlayerSerializer.new(current_player)
  end

  def reset
    Player.delete_all
    redirect_to root_path
  end

  def rebuild
    require "#{Rails.root}/build/build"
    Build.whipe!
    b = Build.new
    b.update_all
    redirect_to root_path
  end

  protected

  def ensure_player
    redirect_to root_path and return if !current_player.present?
  end

end
