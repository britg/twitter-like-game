class BattleProcessor

  attr_accessor :battle

  def initialize _battle
    @battle = _battle
  end

  def participant_names
    @names ||= @battle.participants.map(&:to_s)
  end

  def initiative_processor
    @initiative_processor ||= InitiativeProcessor.new(@battle)
  end

  def evasion_resolver
    @evasion_resolver ||= EvasionResolver.new(@battle)
  end

  def available_actions_for player
    actions = []
    actions << Action.new(label: "Attack", key: :attack)
    actions << Action.new(label: "Skill", key: :special)
    # actions << Action.new(label: "Observe", key: :battle_observe)
    actions << Action.new(label: "Flee", key: :flee)
    actions
  end

  def start
    @battle.players.each do |p|
      p.add_event(
        detail: "Battle has started between #{participant_names.to_sentence}"
      )
    end

    process
  end

  def process
    handle_dead_participants
    do_victory and return if @battle.victory?

    tick_actions = next_tick
    return if tick_actions.last.try(:player_decision?)
    process
  end

  def handle_dead_participants
    # TODO change the status and
    # 'active' flag of participants
    # that are dead
    @battle.npcs.each do |npc|
      if npc.agent.dead?
        npc.update_attributes(dead: true)
        @battle.players.each do |player|
          player.add_event(detail: "#{npc} is dead!")
        end
      end
    end

    @battle.save
  end

  def do_victory
    notify_victory
    assign_loot
    cleanup_battle
  end

  def notify_victory
    @battle.players.each do |player|
      player.add_event(detail: "Victory!")
    end
  end

  def assign_loot
    # TODO
    @battle.players.each do |player|
      player.add_event(detail: "You get some loot...")
    end
  end

  def cleanup_battle
    @battle.players.each do |player|
      player.update_attributes(battle: nil)
      player.add_event("The battle has ended...")
    end
  end

  def next_tick
    @battle.tick!
    battle_actions = initiative_processor.process
    battle_actions.each do |battle_action|
      process_battle_action(battle_action)
      handle_dead_participants
    end
    battle_actions
  end

  def process_battle_action battle_action
    if battle_action.attack?
      # TEMP - need real target determination
      targets = @battle.active_participants - [battle_action.participant]
      process and return if targets.empty?
      perform_attack(battle_action.participant, targets)
    else
      if battle_action.npc_decision?
        process_npc_turn(battle_action.participant)
      else
        prompt_battle_event(battle_action.participant)
      end
    end
  end

  def next_turn!
    @current_turn_participant = initiative_processor.next_participant
    return unless @current_turn_participant.present?
    if @current_turn_participant.player?
      prompt_battle_event @current_turn_participant.player
      return
    end

    process_npc_turn @current_turn_participant
    process
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
      detail: "You've gained the initiative and consider your strategy..."
    )
  end

  def process_npc_turn npc
    profile_proc = CombatProfileProcessor.new(npc.combat_profile,
                                              npc.agent,
                                              @battle)
    action = profile_proc.determine_action
    targets = profile_proc.determine_targets

    @battle.players.each do |player|
      player.add_event(detail: "#{npc.to_s} has seized initiative and chooses [#{action}] against [#{targets.map(&:to_s)}]!")
    end

    #TODO perform action in a more graceful way
    perform_attack(npc, targets) if action.to_sym == :attack
  end


  def attack_from player
    # TODO we are assuming there is only one enemy here!
    perform_attack(player, [@battle.npcs.first])
    process
  end

  def perform_attack attacker, targets
    # TODO Refactor to produce more than one agent delta for
    # an attack
    targets.each do |target|
      agent_delta = AttackDeltaResolver.new(attacker, target.agent).agent_delta
      create_attack_event(target, attacker, agent_delta)
      target.agent.apply_delta(agent_delta)
    end
  end

  def create_attack_event target, perp, agent_delta
    @battle.players.each do |player|
      player.add_event(
        type: Event::ATTACK,
        attacker: perp.to_s,
        attacker_id: perp.id,
        target: target.to_s,
        target_id: target.id,
        delta: agent_delta.to_s,
        detail: "#{perp} attacks: #{target} takes #{agent_delta.to_s} from #{perp}")
    end
  end

end
