class ExplorationProcessor

  class NoLocationDefined < Exception; end

  attr_accessor :player

  def initialize _player
    @player = _player
    ensure_location
  end

  def ensure_location
    raise NoLocationDefined if !location_state.present?
  end

  def location
    @player.location
  end

  def location_state
    @player.current_location_state
  end

  def available_landmarks
    location.landmarks
  end

  def available_landmark_ids
    available_landmarks.map(&:id)
  end

  def landmark_states
    location_state.landmark_states
  end

  def player_landmark_ids
    landmark_states.map(&:landmark_id)
  end

  def undiscovered_landmark_ids
    ids = available_landmark_ids - player_landmark_ids
    ids.map(&:to_s)
  end

  def undiscovered_landmarks
    location.landmarks.find(undiscovered_landmark_ids)
  end

  def first_undiscovered_landmark
    undiscovered_landmarks.each do |landmark|
      return landmark if landmark_proc(landmark).discoverable?
    end
    nil
  end

  def landmark_proc(landmark)
    LandmarkProcessor.new(@player, landmark)
  end

  def combat_proc
    @combat_proc ||= ExplorationCombatProcessor.new(@player, location)
  end

  def resource_proc
    @resource_proc ||= ExplorationResourceProcessor.new(@player, location)
  end

  def explore

    # TEMP - we probably want more logic here
    # e.g. revisiting old landmarks
    # hinting at landmarks
    first_undiscovered_landmark
  end

  def create_explore_event
    @player.add_event(
      detail: location.explore_detail
    )
  end

  def process
    create_explore_event
    return combat_proc.start_battle if combat_proc.combat?
    return resource_proc.start_interaction if resource_proc.resource?
    # If not in combat, determine if we're discovering a resource
    # Or a Landmark

    # skill check against unfound landmarks at a location
    # If you pass against one, create event for it.
    # First
    @found_landmark = explore

    if @found_landmark.present?
      process_landmark @found_landmark
    else
      # when nothing is found, we should somehow remind about
      # the map option.
      create_nothing_found_event
    end
  end

  def process_landmark landmark
    # Add to player's landmarks
    # LandmarkDiscoverer.new(@player, landmark).discover
    landmark_state = location_state.landmark_states.create(landmark_id: landmark.id, slug: landmark.slug)
    create_discovery_event landmark
  end

  def create_discovery_event landmark
    @player.add_event(
      detail: landmark.discovery_detail
    )
  end

  def create_nothing_found_event
    @player.add_event(
      detail: "Nothing new presents itself..."
    )
  end
end
