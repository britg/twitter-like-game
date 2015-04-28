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

  def available_actions_for player
    actions = []
    actions << Action.new(label: "Attack", key: :attack)
    actions << Action.new(label: "Skill", key: :special)
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
    if @battle.victory?
      notify_victory
      assign_loot
      cleanup_battle
    else
      next_turn!
    end
  end

  def handle_dead_participants
    # TODO change the status and
    # 'active' flag of participants
    # that are dead
    @battle.npc_participants.each do |npc_participant|
      if npc_participant.dead?
        npc_participant.update_attributes(active: false)
        @battle.players.each do |player|
          player.add_event("#{npc_participant} is dead!")
        end
      end
    end
    
    @battle.save
  end

  def notify_victory
    @battle.players.each do |player|
      player.add_event("Victory!")
    end
  end

  def assign_loot
    # TODO
    @battle.players.each do |player|
      player.add_event("You get some loot...")
    end
  end

  def cleanup_battle
    @battle.players.each do |player|
      player.update_attributes(battle: nil)
    end
  end

  def next_turn!
    @current_turn_participant = initiative_resolver.next_participant
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
      player.add_event(detail: "[#{npc_participant.to_s}] does [#{action}] against [#{targets.map(&:to_s)}]!")
    end

    #TODO perform action in a more graceful way
    perform_attack(npc_participant, targets) if action.to_sym == :attack
  end


  def attack_from player
    # TODO we are assuming there is only one enemy here!
    perform_attack(player, [@battle.npc_participants.first])
    process
  end

  def perform_attack attacker, targets
    targets.each do |target|
      agent_delta = AttackDeltaResolver.new(attacker, target.agent).agent_delta
      create_attack_event(target, attacker, agent_delta)
      target.agent.apply(agent_delta)
    end
  end

  def create_attack_event target, perp, agent_delta
    @battle.players.each do |player|
      player.add_event(detail: "#{target} takes #{agent_delta.to_s} from #{perp}")
    end
  end



end
