class PlayerMapService

  def initialize player
    @player = player
  end

  def map
    @map = Map.new
    @map.can_travel = @player.can_travel?
    @map.discoveries = []
    @player.location_states.each do |location_state|
      zone = location_state.zone
      i = @map.index_for_zone(zone)
      @map.discoveries[i][:locations] << LocationStateSerializer.new(location_state, root: nil)
    end
    @map
  end

end
