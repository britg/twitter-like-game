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
      process_npc_turn @current_turn_participant.agent
      process
    end
  end

  def flee player
    player.add_event(detail: "You attempt to flee from the battle...")
    player.use_skill(:evasion)
    player.add_event(
      detail: "You successfully escape!"
    )
    player.update_attributes(battle_id: nil)
  end

  def prompt_battle_event player
    player.add_event(
      detail: "You see an opportunity to attack..."
    )
  end

  def process_npc_turn agent
    @battle.players.each do |player|
      #temp
      player.add_event(detail: "Other participant takes their turn...")
    end
  end

end
