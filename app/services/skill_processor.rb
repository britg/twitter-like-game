class SkillProcessor

  attr_accessor :player, :skill, :metadata

  def initialize _player, _slug, _metadata = {}
    @player = _player
    @skill = Skill.where(slug: _slug).first
    @metadata = _metadata
  end

  def process
    # Use metadata to determine chance of increasing this skill
    # and by how much
    raise Skill::InvalidSkill unless @skill.present?
    ensure_player_skill

    # skills range from 0.0 to 100.0 and increase depending on
    # how difficult the use was

    # TEMP
    increase_by 0.1


  end

  def ensure_player_skill
    create_player_skill unless player_skill.present?
  end

  def player_skill
    @player_skill ||= @player.player_skills.where(skill_id: @skill.id).first
  end

  def create_player_skill
    @player_skill = @player.player_skills.create(skill: @skill)
  end

  def increase_by amount = 0.1
    player_skill.inc(value: amount)
    @player.add_event(detail: "Your skill in #{@skill.name} has increased by #{amount}")
  end

end