class PlayerCreationService

  def create
    @player = Player.create(name: I18n.t("tavernlight.default_player_name"))
    PlayerLocationService.new(@player).start!
    ActionHandler.new(@player).proceed!
    @player
  end

end