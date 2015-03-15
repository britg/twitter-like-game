class PlayerLocationService

  attr_accessor :player, :location

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def events
    @player.player_location.where(location_id: @location).events
  end

end