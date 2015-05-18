class ResourceNodeProcessor

  def initialize player
    @player = player
    @node = @player.current_resource_node
  end

  def investigate
    # TODO - a richer set of events: springs a trap, takes damage,
    # spawns a battle, etc.
    # For now just assign loot
    assign_loot
    clear
  end

  def assign_loot
    LootProcessor.new(@player, @node.loot_profile).assign_loot
  end

  def ignore
    @player.add_event("Ignored!")
    clear
  end

  def clear
    @player.update_attributes(resource_node_id: nil)
    @player.consider!
  end

end