class ExplorationProcessor

  class NoLocationDefined < Exception; end

  attr_accessor :player

  def initialize _player
    @player = _player
    ensure_location
  end

  def ensure_location
    raise NoLocationDefined if !player_location.present?
  end

  def location
    @player.location
  end

  def player_location
    @player.current_player_location
  end

  def available_landmarks
    location.landmarks
  end

  def available_landmark_ids
    available_landmarks.map(&:id)
  end

  def player_landmarks
    player_location.player_landmarks
  end

  def player_landmark_ids
    player_landmarks.map(&:landmark_id)
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
      return landmark if landmark_analyzer(landmark).discoverable?
    end
    nil
  end

  def landmark_analyzer(landmark)
    LandmarkAnalyzer.new(@player, landmark)
  end

  def explore
    create_explore_event

    # TEMP - we probably want more logic here
    # e.g. revisiting old landmarks
    # hinting at landmarks
    first_undiscovered_landmark
  end

  def create_explore_event
    @player.add_event(
      detail: location.explore_details.sample
    )
  end

  def process
    # skill check against unfound landmarks at a location
    # If you pass against one, create event for it.
    # First
    @found_landmark = explore
    @player.use_skill(:adventuring)

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
    player_landmark = player_location.player_landmarks.create(landmark_id: landmark.id)
    create_discovery_event landmark

    if landmark_analyzer(landmark).aggro?
      create_aggro_event landmark
      start_battle landmark.obj
    end

  end

  def create_discovery_event landmark
    @player.add_event(
      detail: landmark.discovery_detail
    )
  end

  def create_nothing_found_event
    @player.add_event(
      detail: "You search the area but find nothing interesting..."
    )
  end

  def create_aggro_event landmark
    @player.add_event(
      detail: landmark.aggro_detail
    )
  end

  def start_battle npc
    participating_objs = [@player, npc]
    @battle = BattleCreator.new(participating_objs).create
    BattleProcessor.new(@battle).start
  end

end
