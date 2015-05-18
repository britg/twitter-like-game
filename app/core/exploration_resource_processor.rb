class ExplorationResourceProcessor

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def resource_percentage
    # TODO some kind of calculation here
    20
  end

  def resource?
    @location.resource_nodes? && Rarity.below?(resource_percentage)
  end

  def start_interaction
    node = choose_resource_node
    @player.update_attributes(resource_node_id: node.id)
    @player.add_event(
      detail: node.discovery_details.sample
    )
  end

  def choose_resource_node
    # TODO player skills vs available resources
    @location.resource_nodes.sample
  end

end
