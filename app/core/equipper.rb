class Equipper

  def initialize player, equipment
    @player = player
    @equipment = equipment
  end

  def equip
    player_slot = @player.agent.slot(@equipment.slot.slug)
    player_slot.equipment = @equipment
    # TODO call for re-caching the agent stats
    @player.save
  end

end
