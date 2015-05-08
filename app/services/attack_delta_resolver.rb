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
    amount = -Random.rand(5) - 5
    AgentDelta.new(type: "Stat", slug: "hp", amount: amount)
  end

end
