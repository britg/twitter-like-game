class InitiativeResolver

  class InvalidInitiative < Exception; end

  def initialize _battle
    @battle = _battle
  end

  def participants
    @battle.participants.active
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
