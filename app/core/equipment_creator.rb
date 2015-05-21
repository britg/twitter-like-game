class EquipmentCreator

  def initialize player, blueprint
    @blueprint = blueprint
    @player = player
  end

  def create
    @equipment = Equipment.new(
      slot: @blueprint.slot,
      name: generate_name,
      rarity: @blueprint.rarity,
      level_requirement: @blueprint.level_requirement,
      player: @player,
      max_durability: @blueprint.durability,
      skill: @blueprint.skill
    )

    @blueprint.agent_deltas.each do |agent_delta|
      @equipment.agent_deltas.build(
        type: agent_delta.type,
        slug: agent_delta.slug,
        range: agent_delta.range,
        amount: agent_delta.value # Always calc an amount on creation
      )
    end

    @equipment.agent_requirements = @blueprint.agent_requirements
    @equipment.save

    @equipment
  end

  def generate_name
    # TODO Diablo-style name generator
    @blueprint.base_name
  end

end
