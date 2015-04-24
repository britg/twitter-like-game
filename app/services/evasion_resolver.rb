class EvasionResolver

  def initialize _battle
    @battle = _battle
  end

  def attempt_evade(participant_obj)
    # TODO do some kind of determination
    successful = [true, false].sample
    participant_obj.use_skill(:evasion)
    successful
  end

end
