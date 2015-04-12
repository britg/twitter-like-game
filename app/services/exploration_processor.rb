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

  def player_location
    @player.current_player_location
  end

  def process
    # skill check against unfound landmarks at a location
    # If you pass against one, create event for it.
    # First
  end

end