class EvasionResolver

  def initialize _battle
    @battle = _battle
  end

  def attempt_evade(participant)
    # TODO do some kind of determination
    successful = [true, true].sample
    participant.use_skill(:evasion) if participant.player?
    successful
  end

end
