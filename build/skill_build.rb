class SkillBuild < ObjectBuild

  def props
    {
      name: @hash["name"],
      slug: @hash["slug"],
      group: @hash["group"]
    }
  end

  def create
    @skill = Skill.create(props)
  end

  def update
    @skill = existing
    @skill.update_attributes(props)
    @skill
  end

end
