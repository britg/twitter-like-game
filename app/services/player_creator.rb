class PlayerCreator

  attr_accessor :player

  def create
    create_player
    set_default_location
    @player.save
    initial_quest_items
    initial_equipment
    initial_consumables
    @player
  end

  def create_player
    @player = Player.create(
      name: "Traveller",
      gold: configatron.player_gold
    )

    create_stats
  end

  def create_stats
    @agent = @player.create_agent
    @player.stats.create(
      slug: :hp,
      base_value: configatron.player_base_hp
    )
    @player.stats.create(
      slug: :str,
      base_value: configatron.player_base_strength
    )
  end

  def set_default_location
    @location = Location.where(slug: configatron.location).first
    LocationProcessor.new(@player, @location).initial_location
  end

  def initial_quest_items
    configatron.initial_quest_items.each do |slug|
      QuestItemCreator.new(QuestItemBlueprint.slug(slug), @player).create
    end
  end

  def initial_equipment
    configatron.initial_equipment.each do |slug|
      EquipmentCreator.new(EquipmentBlueprint.slug(slug), @player).create
    end
  end

  def initial_consumables
    configatron.initial_consumables.each do |slug|
      ConsumableCreator.new(ConsumableBlueprint.slug(slug), @player).create
    end
  end

end
