class GameController < ApplicationController

  before_filter :ensure_player

  def index
    @player_json = PlayerSerializer.new(current_player)
  end

  def inventory

  end

  def landmarks

  end

  def stats

  end

  protected

  def ensure_player
    redirect_to root_path and return if !current_player.present?
  end

end
