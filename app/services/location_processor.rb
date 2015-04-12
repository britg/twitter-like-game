class LocationProcessor

  class SameLocationError < Exception; end

  attr_accessor :player, :location

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def enter
    return if already_at_location?
    set_location
    create_location_entrance_event
    ensure_player_location
    @player.save
  end

  def already_at_location?
    @location.id == @player.location_id
  end

  def set_location
    @player.location = @location
  end

  def create_location_entrance_event
    e = @player.events.create(
      detail: @location.entrance_description,
    )
    e.add_exploration_actions
  end

  def ensure_player_location
    create_player_location unless @player.current_player_location.present?
  end

  def create_player_location
    @player.player_locations.create(
      location_id: @location.id
    )
  end

end