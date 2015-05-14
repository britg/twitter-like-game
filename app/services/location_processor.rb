class LocationProcessor

  class SameLocationError < Exception; end

  attr_accessor :player, :location

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def initial_location
    set_location
    ensure_player_location
    auto_discover_landmarks
    @player.save
  end

  def enter
    raise "Cannot travel - you're in battle!" if @player.in_battle?
    raise "Already at location" if already_at_location?
    set_location
    # create_location_entrance_event
    create_story_events
    ensure_player_location
    auto_discover_landmarks
    @player.save
  end

  def already_at_location?
    @location.id == @player.location_id
  end

  def set_location
    @player.location = @location
  end

  def create_location_entrance_event
    @player.add_event(
      detail: @location.entrance_detail
    )
  end

  def create_story_events
    @location.story.each do |detail|
      @player.add_event(detail: detail)
    end
  end

  def ensure_player_location
    create_location_state unless @player.current_location_state.present?
  end

  def create_location_state
    @player.location_states.create(
      location_id: @location.id
    )
  end

  def auto_discover_landmarks
    @location.landmarks.each do |landmark|
      auto_discover_landmark(landmark) if landmark.auto_discovered?
    end
  end

  def auto_discover_landmark landmark
    @player.current_landmark_states
      .find_or_create_by(landmark_id: landmark.id, slug: landmark.slug)
  end


end
