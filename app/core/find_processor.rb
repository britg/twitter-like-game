class FindProcessor

  def initialize(_player)
    @player = _player
  end

  def process_random
    @player.add_event(
      detail: "You attempt to find stuff..."
    )
  end

  def process_survival
    @player.add_event(
      detail: "You gather some branches for a fire"
    )
  end

  def process_resource resource_slug
    @player.add_event(
      detail: "You attempt to find #{resource_slug}"
    )
  end

end
