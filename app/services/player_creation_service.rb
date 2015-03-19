class PlayerCreationService

  def initialize
  end

  def create
    @player = Player.create(name: I18n.t("tavernlight.default_player_name"))
    @player.current_location = @player.player_locations.find_or_create_by(location_id: start_location.id)
    @player
  end

  def start_location
    Location.where(slug: "tavern").first
  end

end