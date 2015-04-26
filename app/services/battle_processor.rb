class BattleProcessor

  attr_accessor :battle

  def initialize _battle
    @battle = _battle
  end

  def participant_names
    @names ||= @battle.participants.map(&:to_s)
  end

  def initiative_resolver
    @initiative_resolver ||= InitiativeResolver.new(@battle)
  end

  def evasion_resolver
    @evasion_resolver ||= EvasionResolver.new(@battle)
  end

  def start
    @battle.players.each do |p|
      p.add_event(
        detail: "Battle has started between #{participant_names.to_sentence}"
      )
    end

    process
  end

  def attack_from player
    player.add_event(detail: "You attack for massive damage!")
    process
  end

  def process
    debug "processing battle"
    @current_turn_participant = initiative_resolver.next_participant
    if @current_turn_participant.player?
      prompt_battle_event @current_turn_participant.player
    else
      process_npc_turn @current_turn_participant
      process
    end
  end

  def flee player
    player.add_event(detail: "You attempt to run from battle...")
    if evasion_resolver.attempt_evade(player)
      player.add_event(
        detail: "You successfully escape!"
      )
      player.update_attributes(battle_id: nil)
    else
      player.add_event(detail: "You're unable to escape!")
      process
    end
  end

  def prompt_battle_event player
    player.add_event(
      detail: "You see an opportunity to attack..."
    )
  end

  def process_npc_turn npc_participant
    profile_proc = CombatProfileProcessor.new(npc_participant.combat_profile,
                                              npc_participant.agent_instance,
                                              @battle)
    action = profile_proc.determine_action
    targets = profile_proc.determine_targets

    @battle.players.each do |player|
      player.add_event(detail: "[#{npc.to_s}] does [#{action}] against [#{targets}]!")
    end

    #TODO perform action in a more graceful way
    perform_attack(npc_participant, targets) if action.to_sym == :attack
    process
  end
  
  def perform_attack npc_participant, targets
    targets.each do |target|
      agent_delta = AttackProcessor.new(npc_participant, target.agent).agent_delta
      apply_agent_delta(target.agent, agent_delta)

    end
  end

  def apply_agent_delta agent, delta
    #TODO delegate to some service to apply the delta

  end

  def available_actions_for player
    actions = []
    actions << Action.new(label: "Attack", key: :attack)
    actions << Action.new(label: "Skill", key: :special)
    actions << Action.new(label: "Flee", key: :flee)
    actions
  end

end
