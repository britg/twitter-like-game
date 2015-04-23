class LandmarkAnalyzer

  attr_accessor :player, :landmark

  def initialize _player, _landmark
    @player = _player
    @landmark = _landmark
  end

  # True if meets _all_ of the checks
  def discoverable?
    fails_any = false
    @landmark.discovery_requirements.each do |skillreq|
      fails_any = true unless meets?(skillreq)
    end

    return !fails_any
  end

  def meets? skillreq
    skill = @player.skill(skillreq.skill.slug)
    # debug skillreq.range, skillreq.skill.name, val
    skillreq.range.include?(skill.value)
  end

end
