class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :find_player
  helper_method :current_player

  def current_player
    @current_player
  end

  def continue_token
    @continue_token ||= (cookies.signed[:continue_token])
  end

  protected

  def find_player
    return nil unless continue_token.present?
    @current_player = Player.where(continue_token: continue_token).first
  end

  def player_location_path
    "/#{current_player.location.slug}"
  end

  def redirect_to_player_location
    redirect_to player_location_path and return if current_player.present? && request.path != player_location_path
  end

end
