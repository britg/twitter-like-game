class LocationProcessor

  class SameLocationError < Exception; end

  attr_accessor :player, :location

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def enter
    raise "Cannot travel - you're in battle!" if @player.in_battle?
    raise "Already at location" if already_at_location?
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
    @player.add_event(
      detail: @location.entrance_detail
    )
  end

  def ensure_player_location
    create_location_state unless @player.current_location_state.present?
  end

  def create_location_state
    @player.location_states.create(
      location_id: @location.id
    )
  end

end
