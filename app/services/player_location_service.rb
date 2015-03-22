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
    @player.save
  end

end