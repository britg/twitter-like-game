class LandmarkProcessor

  attr_accessor :player, :landmark

  def initialize _player, _landmark
    @player = _player
    @landmark = _landmark
  end

  # True if meets _all_ of the checks
  def discoverable?
    fails_any = false

    # TODO Loop through agent requirements

    return !fails_any
  end

  # def meets? skillreq
  #   skill = @player.skill(skillreq.skill.slug)
  #   # debug skillreq.range, skillreq.skill.name, val
  #   skillreq.range.include?(skill.value)
  # end

end
