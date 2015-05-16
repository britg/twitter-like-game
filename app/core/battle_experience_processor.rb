class BattleExperienceProcessor

  def initialize player, battle
    @player = player
    @battle = battle
  end

  def amount
    # TODO come up with a real system based on player level
    # and the levels of the battle npcs
    return rand(50..100)
  end

end