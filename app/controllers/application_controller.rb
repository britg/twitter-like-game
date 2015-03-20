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

  def continue_token
    @continue_token ||= (request.headers["X-Continue-Token"]||params[:continue_token])
  end

  protected

  def find_player
    return nil unless continue_token.present?
    @current_player = Player.where(continue_token: continue_token).first
  end

end
