class ConsumableCreator

  def initialize blueprint, player
    @blueprint = blueprint
    @player = player
  end

  def create
    @consumable = Consumable.new(
      name: @blueprint.name,
      rarity: @blueprint.rarity,
      level_requirement: @blueprint.level_requirement,
      player: @player
    )

    @blueprint.agent_deltas.each do |agent_delta|
      @consumable.agent_deltas.build(
        type: agent_delta.type,
        slug: agent_delta.slug,
        range: agent_delta.range,
        amount: agent_delta.value # Always calc an amount on creation
      )
    end

    @consumable.agent_requirements = @blueprint.agent_requirements

    @consumable.save and @consumable
  end

end
