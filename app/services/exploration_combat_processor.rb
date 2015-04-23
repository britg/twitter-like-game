# Determine if we're doing combat or not by comparing
# adventuring with location's adventuring_level
  # If combat, start a battle

class ExplorationCombatProcessor

  def initialize _player, _location
    @player = _player
    @location = _location
  end

  def combat_percentage
    # TODO @player.adventuring vs. @location.adventuring_level
    50
  end

  def combat?
    @location.mobs? && Rarity.below(combat_percentage)
  end

  def start_battle
    mob = choose_mob
    create_aggro_event(mob)
    create_battle(mob.npc)
  end

  def choose_mob
    # TODO
    # Make this rarity based.
    @location.mobs.sample
  end

  def create_aggro_event mob
    @player.add_event(
      detail: "#{mob.to_s} notices you and attacks!"
    )
  end

  def create_battle npc
    participating_objs = [@player, npc]
    @battle = BattleCreator.new(participating_objs).create
    BattleProcessor.new(@battle).start
  end

end
