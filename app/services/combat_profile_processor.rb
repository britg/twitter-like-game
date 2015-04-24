class CombatProfileProcessor

  def initialize npc, battle
    @npc = npc
    @battle = battle
  end

  def process
    # TODO
    # Use the npc's combat profile to determine the next
    # course of action
    @action = determine_action

    @battle.players.each do |player|
      #temp
      player.add_event(detail: "[#{@npc.to_s}] does [#{@action}]!")
    end
  end

  def determine_action
    @profile = @npc.combat_profile
    @result = :attack

    @profile.combat_profile_conditions.each do |condition|
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

end
