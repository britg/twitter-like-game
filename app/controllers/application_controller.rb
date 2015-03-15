class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_player

  def ember_start
    render :ember_start, layout: false
  end

  def current_player
    @current_player = Player.where(id: cookies[:player_id]).first || create_player
  end

  def create_player
    player = Player.create()
    cookies[:player_id] = player.id
    player
  end

end
