class BattleTemplate

  attr_accessor :agents, :return_scene, :return_waypoint

  def initialize template
    @agents = template[:agents]
    @return_scene = template[:return_to][:scene]
    @return_waypoint = template[:return_to][:waypoint]
  end

end