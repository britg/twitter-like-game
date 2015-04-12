class PlayerCreator

  attr_accessor :player

  def create
    create_player
    set_default_location
    @player.save and @player
  end

  def create_player
    @player = Player.create
  end

  def set_default_location
    @location = Location.where(slug: configatron.location).first
    LocationProcessor.new(@player, @location).enter
  end

end