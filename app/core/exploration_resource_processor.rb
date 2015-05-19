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
    return true
    @location.resource_nodes? && Rarity.below?(resource_percentage)
  end

  def start_interaction
    node = choose_resource_node
    @player.update_attributes(resource_node_id: node.id)
    @player.current_location_state.inc(resource_node_count: 1)
    @player.add_event(
      format: Event::RESOURCE,
      resource_name: node.name,
      detail: node.discovery_details.sample
    )
  end

  def choose_resource_node
    # TODO player skills vs available resources
    @location.resource_nodes.sample
  end

end
