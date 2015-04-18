class FindProcessor

  def initialize(_player)
    @player = _player
  end

  def process_random
    @player.exploration_event(
      detail: "You attempt to find stuff..."
    )
  end

  def process_resource resource_slug
    @player.exploration_event(
      detail: "You attempt to find #{resource_slug}"
    )
  end

end
