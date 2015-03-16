class PlayerLocationService

  attr_accessor :player, :location

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def player_location
    @player.player_locations.find_or_create_by(location_id: @location.id)
  end

end