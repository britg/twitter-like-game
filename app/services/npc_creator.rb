class NpcCreator

  def initialize npc_blueprint
    @npc_blueprint = npc_blueprint
  end

  def create
    @npc = Npc.create(name: @npc_blueprint.name,
                      combat_profile: @npc_blueprint.combat_profile)
    create_agent
    @npc
  end

  def create_agent
    @npc.create_agent
    # TODO use the blueprint to assign skill and stat
    # ranges
  end

end
