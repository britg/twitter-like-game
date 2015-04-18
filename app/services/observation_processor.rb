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
    create_observe_event
    create_percent_explored_event
  end

  def explored_percentage
    landmark_count = location.landmarks.count
    raise "No landmarks" unless landmark_count > 0
    player_count = player_location.player_landmarks.count
    percent = (player_count.to_f / landmark_count.to_f)*100
  end

  def create_percent_explored_event
    @player.add_event(
      detail: "You estimate you've explored about #{explored_percentage.round}% of the area..."
    )
  end

  def create_observe_event
    @player.add_event(
      detail: location.observe_details.sample
    )
  end

end
