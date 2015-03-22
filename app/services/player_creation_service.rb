class PlayerCreationService

  def initialize
  end

  def create
    @player = Player.create(name: I18n.t("tavernlight.default_player_name"))
    PlayerLocationService.new(@player).start!
    # EventEngine.new(@player).next!
    @player
  end

end