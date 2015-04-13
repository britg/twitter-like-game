class LandmarkAnalyzer

  attr_accessor :player, :landmark

  def initialize _player, _landmark
    @player = _player
    @landmark = _landmark
  end

  # True if meets _all_ of the checks
  def discoverable?
    fails_any = false
    @landmark.discovery_conditions.each do |skillreq|
      fails_any = true unless meets?(skillreq)
    end

    return !fails_any
  end

  # True if meets _any_ of the checks
  def aggro?
    return false unless @landmark.aggro_conditions.any?
    @landmark.aggro_conditions.each do |skillreq|
      return true if meets?(skillreq)
    end
  end

  def meets? skillreq
    val = @player.player_skills.value_for_skill(skillreq.skill) \
      || @player.player_skills.create(skill: skillreq.skill).value
    # debug skillreq.range, skillreq.skill.name, val
    skillreq.range.include?(val)
  end

end