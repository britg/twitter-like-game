class Api::V1::PlayersController < ApplicationController

  before_filter :ensure_player, only: :show

  def show
    render json: current_player,
           serializer: CurrentPlayerSerializer,
           root: "player"
  end

  def create
    create_player
    head 201
  end

  protected

  def ensure_player
    create_player unless current_player.present?
  end

  def create_player
    @current_player = Player.create(name: t("tavernlight.default_player_name"))
    cookies.permanent.signed[:player_id] = @current_player.id.to_s
  end


end