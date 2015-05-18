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

  def npcs_as_sentence
    @npcs_as_sentence ||= @battle.npcs.map(&:to_s).to_sentence
  end

  def available_actions_for player
    if @battle.started?
      return initiative_actions_for player
    else
      return approach_actions_for player
    end
  end

  def initiative_actions_for player
    actions = []
    actions << Action.new(label: "Attack", key: :attack, feedback: "You continue battle...")
    actions << Action.new(label: "Skill", key: :special)
    # actions << Action.new(label: "Observe", key: :battle_observe)
    actions << Action.new(label: "Flee", key: :flee, feedback: "You attempt to flee from battle...")
    actions
  end

  def approach_actions_for player
    actions = []
    actions << Action.new(label: "Attack", key: :attack, feedback: "You dive into battle...")
    actions << Action.new(label: "Avoid", key: :avoid, feedback: "You attempt to avoid a confrontation...")
    actions << Action.new(label: "Observe", key: :battle_observe, feedback: "You take stock of the situation...")
    actions
  end

  def prompt_approach
    # TODO Bestiary stuff
    @battle.players.each do |player|
      player.add_event(
        format: Event::MOB_APPROACH,
        target: npcs_as_sentence,
        detail: "You spot #{npcs_as_sentence} ahead."
      )
    end
  end

  def process
    @battle.update_attributes(started: true)
    check_dead_participants
    do_victory and return if @battle.victory?

    tick_results = next_tick
    return if tick_results.last.try(:player_decision?)
    process
  end

  def next_tick
    @battle.tick!
    battle_turns = initiative_processor.process
    battle_turns.each do |battle_turn|
      next if battle_turn.participant.dead?
      process_battle_turn(battle_turn)
      check_dead_participants
    end
    battle_turns
  end

  def check_dead_participants
    @battle.active_participants.each do |participant|
      if !participant.dead?
        died = participant.agent.dead?
        if died && participant.npc?
          notify_npc_died(participant)
          participant.transition_to_dead
        end
      end
    end

    @battle.save
  end

  def notify_npc_died npc
    npc.update_attributes(dead: true)
    @battle.players.each do |player|
      player.add_event(
        format: Event::NPC_DEATH,
        target: npc,
        target_id: npc.id,
        detail: "#{npc} has died"
      )
    end
  end

  def do_victory
    notify_victory
    assign_loot
    assign_experience
    cleanup_battle
  end

  def notify_victory
    @battle.players.each do |player|
      player.add_event(detail: "Victory!")
    end
  end

  def assign_loot
    @battle.players.each do |player|
      @battle.npcs.each do |npc|
        LootProcessor.new(player, npc.loot_profile).assign_loot
      end
    end
  end

  def assign_experience
    @battle.players.each do |player|
      xp = BattleExperienceProcessor.new(player, @battle).amount
      player.gain_experience(xp)
    end
  end

  def cleanup_battle
    @battle.players.each do |player|
      player.update_attributes(battle: nil)
      player.add_event("You gather yourself after battle.")
    end
  end


  def process_battle_turn battle_turn
    if battle_turn.attack?
      # TEMP - need real target determination
      targets = @battle.active_participants - [battle_turn.participant]
      process and return if targets.empty?
      perform_attack(battle_turn.participant, targets)
    else
      if battle_turn.npc_decision?
        process_npc_turn(battle_turn.participant)
      else
        prompt_battle_event(battle_turn.participant)
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

  def observe player
    @battle.npcs.each do |npc|
      BestiaryProcessor.new(player, npc).observe
    end
  end

  def avoid player
    if evasion_resolver.attempt_evade(player)
      player.add_event(
        detail: "You avoid #{npcs_as_sentence}"
      )
      player.update_attributes(battle_id: nil)
    else
      player.add_event(detail: "You're unable to avoid #{npcs_as_sentence} and they attack")
      process
    end
  end

  def flee player
    if evasion_resolver.attempt_evade(player)
      player.add_event(
        detail: "You successfully escape!"
      )
      player.update_attributes(battle_id: nil)
    else
      player.add_event(detail: "Unable to escape!")
      process
    end
  end

  def prompt_battle_event player
    player.add_event(
      detail: "You have gained the initiative and consider your strategy..."
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
    attacker.use_main_hand_skill if attacker.player?

    targets.each do |target|
      agent_delta = AttackDeltaResolver.new(attacker, target.agent).agent_delta
      target.agent.apply_delta(agent_delta)
      create_attack_event(target, attacker, agent_delta)
    end
  end

  def create_attack_event target, perp, agent_delta
    @battle.players.each do |player|
      player.add_event(
        format: Event::ATTACK,
        attacker: perp.to_s,
        attacker_id: perp.id,
        target: target.to_s,
        target_id: target.id,
        delta: agent_delta.to_s,
        detail: "#{perp} attacks: #{target} takes #{agent_delta.to_s} from #{perp}")
    end
  end

end
