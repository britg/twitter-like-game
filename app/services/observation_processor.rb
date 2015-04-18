class ObservationProcessor

  def initialize _player
    @player = _player
  end

  def ensure_location
    raise ExplorationProcessor::NoLocationDefined if !location_state.present?
  end

  def location_state
    @player.current_location_state
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
    player_count = location_state.landmark_states.count
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
