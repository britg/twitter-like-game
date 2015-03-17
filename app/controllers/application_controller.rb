class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :find_player
  helper_method :current_player

  def ember_start
    render :ember_start, layout: false
  end

  def current_player
    @current_player
  end

  def player_cookie
    cookies.signed[:player_id]
  end

  protected

  def find_player
    @current_player = Player.where(id: player_cookie).first
    @current_player.try(:is_current_player!)
  end

end
