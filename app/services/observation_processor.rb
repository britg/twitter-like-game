class ObservationProcessor

  def initialize _player
    @player = _player
  end

  def ensure_location
    raise ExplorationProcessor::NoLocationDefined if !location_state.present?
  end

  def location_state
    @location_state ||= @player.current_location_state
  end

  def location
    @location ||= @player.location
  end

  def process
    create_observe_event
    # create_percent_explored_event
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

  def next_observation_detail_index
    details = location.observe_details.to_a
    observed_index = location_state.observed_details.last || -1
    observed_index+1
  end

  def next_observation_detail
    details = location.observe_details.to_a
    next_index = next_observation_detail_index
    if next_index >= details.count
      next_index = 0
      location_state.observed_details = [0]
    else
      location_state.observed_details << next_index
    end

    location_state.save
    return details[next_index]
  end

  def create_observe_event
    @player.add_event(
      detail: next_observation_detail
    )
  end

end
