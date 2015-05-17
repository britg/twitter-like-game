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
    100
  end

  def combat?
    @location.mobs? && Rarity.below(combat_percentage)
  end

  def start_battle
    mob = choose_mob
    npc = generate_npc(mob)
    create_battle(npc)
    # create_aggro_event(npc)
  end

  def choose_mob
    # TODO
    # Make this rarity based.
    @location.mobs.sample
  end

  def create_aggro_event npc
    @player.add_event(
      format: Event::AGGRO,
      attacker: npc,
      attacker_id: npc.id,
      target: @player,
      target_id: @player.id,
      detail: "#{npc} notices you and attacks!"
    )
  end

  def generate_npc mob
    npc = NpcCreator.new(mob.npc_blueprint).create
  end

  def create_battle npc
    @battle = BattleCreator.new([@player], [npc]).create
    @player.current_location_state.inc(battle_count: 1)
    BattleProcessor.new(@battle).prompt_approach
  end

end
