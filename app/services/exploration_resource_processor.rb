class ExplorationResourceProcessor

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def resource?
    # TODO player skills vs available resources
    false
  end

  def start_interaction
    resource_node = choose_resource_node
  end

  def choose_resource_node
    @location.resource_nodes.sample
  end

end
