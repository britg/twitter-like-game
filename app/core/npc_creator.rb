class NpcCreator

  def initialize npc_blueprint
    @npc_blueprint = npc_blueprint
  end

  def create
    @npc = Npc.create(name: @npc_blueprint.name,
                      npc_blueprint: @npc_blueprint,
                      combat_profile: @npc_blueprint.combat_profile)
    create_agent
    @npc
  end

  def create_agent
    @npc.create_agent
    # TODO use the blueprint to assign skill and stat
    # ranges

    @npc_blueprint.agent_attributes.each do |agent_delta|
      convert_agent_delta_to_agent_attribute(agent_delta)
    end
  end

  def convert_agent_delta_to_agent_attribute agent_delta
    if agent_delta.stat?
      @npc.agent.stats.create(
        slug: agent_delta.slug,
        base_value: agent_delta.amount,
      )
    end
  end

end
