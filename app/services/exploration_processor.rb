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

  def undiscovered_landmarks
    ids = location.landmarks.map(&:id) - player_location.player_landmarks.map(&:id)
    location.landmarks.where(id: ids)
  end

  def first_discoverable_landmark
    undiscovered_landmarks.each do |landmark|
      return landmark if landmark.discoverable?(@player)
    end
  end

  def process
    # skill check against unfound landmarks at a location
    # If you pass against one, create event for it.
    # First
    @found_landmark = first_discoverable_landmark
    @player.sk(:adventuring, difficulty: 50)
    create_nothing_found_event unless @found_landmark.present?
  end

  def create_nothing_found_event
    e = @player.add_event(
      detail: "You search the area but find nothing interesting."
    )
  end

end