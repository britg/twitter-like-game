class PlayerLocationService

  attr_accessor :player

  def initialize _player
    @player = _player
  end

  def start!
    enter_location(start_location)
  end

  def start_location
    Location.where(slug: "tavern").first
  end

  def enter_location location
    @player.location = location

    # If the player has not completed the initial
    # scripted event for a location, start it
    scripted_event = location.scripted_events.first
    @player.current_scripted_event_id = scripted_event.id
    @player.current_mode = scripted_event.mode
    @player.save
  end

end