class InitiativeResolver

  def initialize _battle
    @battle = _battle
  end

  # return the next participant
  def next
    # Temp
    @battle.participants.sample
  end

end
