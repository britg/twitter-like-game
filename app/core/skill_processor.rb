class SkillProcessor

  attr_accessor :player, :skill, :metadata

  def initialize _player, _slug, _metadata = {}
    @player = _player
    @skill = Skill.where(slug: _slug).first
    raise Skill::InvalidSkill unless @skill.present?
    @player_skill = @player.skill(@skill.slug)
    @metadata = _metadata
  end

  def process
    # Use metadata to determine chance of increasing this skill
    # and by how much

    # skills range from 0.0 to 100.0 and increase depending on
    # how difficult the use was

    # TEMP
    if Rarity.below(50)
      increase_by 0.1
    else
      nil
    end
  end

  def increase_by amount = 0.1
    @player_skill.inc(base_value: amount)
    # @player.save
    @player.add_event(detail: "+ #{amount} #{@skill.name} (#{@player_skill.value})")
  end

end
