class PlayerCreator

  def create
    @player = Player.create(name: I18n.t("tavernlight.default_player_name"))
    SceneService.new(@player).proceed
    @player
  end

end