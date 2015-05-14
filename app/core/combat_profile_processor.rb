class CombatProfileProcessor

  def initialize combat_profile, agent_instance, battle
    @combat_profile = combat_profile
    @agent_instance = agent_instance
    @battle = battle
  end

  def determine_action
    # TODO
    # Use the npc's combat profile to determine the next
    # course of action
    @result = :attack

    return @result unless @combat_profile.present?

    @combat_profile.combat_profile_conditions.each do |condition|
      if meets?(condition)
        @result = condition.result
        break
      end
    end
    @result
  end

  def meets? condition
    # TODO see if the battle meets the conditions
    true
  end

  def determine_targets
    [@battle.players.first]
  end

end
