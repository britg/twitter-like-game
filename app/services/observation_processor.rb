class ObservationProcessor

  def initialize _player
    @player = _player
  end

  def ensure_location
    raise ExplorationProcessor::NoLocationDefined if !player_location.present?
  end

  def player_location
    @player.current_player_location
  end

  def location
    @player.location
  end

  def process
    @player.exploration_event(
      detail: location.observe_details.sample
    )
  end

end
