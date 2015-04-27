class AttackDeltaResolver

  def initialize attacking_agent, target_agent
    @attacking_agent = attacking_agent
    @target_agent = target_agent
  end

  def agent_delta
    #TODO determine agent delta
    # use agent info like:
      # weapon
      # str, dex, etc
    AgentDelta.new(hp: -Random.rand(5) - 5)
  end

end
