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

  def process
    create_explore_event
    create_observe_event
    return combat_proc.start_battle if combat_proc.combat?
    return resource_proc.start_interaction if resource_proc.resource?

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

  def explore
    # TEMP - we probably want more logic here
    # e.g. revisiting old landmarks
    # hinting at landmarks
    first_undiscovered_landmark
  end

  def create_observe_event
    ObservationProcessor.new(@player).create_observe_event
  end

  def create_explore_event
    @player.add_event(
      detail: location.explore_detail
    )
  end


  def process_landmark landmark
    # Add to player's landmarks
    # LandmarkDiscoverer.new(@player, landmark).discover
    landmark_state = location_state.landmark_states.create(landmark_id: landmark.id, slug: landmark.slug)
    create_discovery_event landmark
  end

  def create_discovery_event landmark
    @player.add_event(
      type: Event::DISCOVERY,
      detail: landmark.discovery_detail,
      landmark_name: landmark.name,
      landmark_slug: landmark.slug
    )
  end

  def create_nothing_found_event
    @player.add_event(
      detail: "You cover new ground but don't find anything else interesting."
    )
  end

  def available_actions
    actions = []
    actions << Action.new(label: "Explore", key: :explore)

    actions << Action.new(label: "Observe", key: :observe)

    # find_action = Action.new(label: "Find", key: :find)
    # find_action.child_actions.build(label: "Reagents", key: "find->reagents")
    # find_action.child_actions.build(label: "Ore", key: "find->ore")
    # find_action.child_actions.build(label: "Wood", key: "find->wood")
    # actions << find_action

    if @player.current_landmark_states.any?
      landmarks_action = Action.new(label: "Landmarks", key: :landmark)
      @player.current_landmark_states.each do |landmark_state|
        landmarks_action.child_actions.build(label: landmark_state.to_s, key: landmark_state.to_action_key)
      end
      actions << landmarks_action
    end
    # actions << Action.new(label: "Craft", key: :craft)
    actions
  end
end
