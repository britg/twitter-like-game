class PlayerCreator

  attr_accessor :player

  def create
    create_player
    set_default_location
    @player.save and @player
  end

  def create_player
    @player = Player.create(
      name: "Stranger",
      gold: configatron.player_gold
    )

    create_stats
  end

  def create_stats
    @agent = @player.create_agent
    @player.stats.create(
      slug: :str,
      base_value: configatron.player_base_strength
    )
  end

  def set_default_location
    @location = Location.where(slug: configatron.location).first
    LocationProcessor.new(@player, @location).enter
  end

end