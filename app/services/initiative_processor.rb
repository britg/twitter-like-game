class InitiativeProcessor

  class InvalidInitiative < Exception; end

  def initialize _battle
    @battle = _battle
  end

  def participants
    @participants ||= @battle.active_participants
  end

  def process
    @tick_actions = []

    attack_actions
    decision_actions

    @tick_actions.sort_by{ |a| a.player_decision? ? 1 : 0 }
  end

  def attack_actions
    participants.each do |participant|
      participant.agent.tap do |agent|
        agent.current_battle_tick += 1

        if agent.current_battle_tick >= agent.attack_speed.value
          @tick_actions << BattleTurn.new(
            type: BattleTurn::ATTACK,
            participant: participant
          )
          agent.current_battle_tick = 0
        end

      end
      participant.save
    end
  end

  def decision_actions
    participants.each do |participant|
      participant.agent.tap do |agent|
        agent.current_initiative += agent.ap.value

        if agent.current_initiative >= @battle.combined_initiative
          @tick_actions << BattleTurn.new(
            type: BattleTurn::DECISION,
            participant: participant
          )
          agent.current_initiative -= @battle.combined_initiative
        end
      end
      participant.save
    end
  end

  # return the next participant
  def next_participant
    return nil unless participants.any?
    loop do
      participants.each do |participant|
        raise InvalidInitiative if participant.ap.value < 1
        participant.current_initiative += participant.ap.value
        if participant.current_initiative >= @battle.combined_initiative
          participant.current_initiative -= @battle.combined_initiative
          participants.map(&:save)
          return participant
        end
      end
    end
  end

end
