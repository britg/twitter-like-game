class CombatProfileBuild < ObjectBuild

  def props
    {
      name: @hash["name"],
      slug: @hash["slug"],
    }
  end

  def create
    @combat_profile = CombatProfile.create(props)
    update
  end

  def update
    @combat_profile ||= existing
    @combat_profile.update_attributes(props)
    embed_combat_profile_conditions
  end

  def embed_combat_profile_conditions
    
  end

end
