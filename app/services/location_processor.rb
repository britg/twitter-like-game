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
    reset_exploration_state
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
    e.actions.create(label: "Explore", key: :explore)
  end

  def reset_exploration_state
    @player.create_exploration_state unless @player.exploration_state.present?
    @player.exploration_state.update_attributes(
      last_event_time: Time.now,
      current_event_count: 1
    )
  end

end