class CombatProfileProcessor

  def initialize npc, battle
    @npc = npc
    @battle = battle
  end

  def process
    # TODO
    # Use the npc's combat profile to determine the next
    # course of action

    @battle.players.each do |player|
      #temp
      player.add_event(detail: "[#{@npc.to_s}] makes a move!")
    end
  end

end
