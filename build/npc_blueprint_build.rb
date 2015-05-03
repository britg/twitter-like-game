class NpcBlueprintBuild < ObjectBuild

  def props
    {
      name: @hash["name"],
      slug: @hash["slug"],
    }
  end

  def create
    @npc_blueprint = NpcBlueprint.create(props)
    associate_combat_profile
    embed_stat_blueprints
    embed_skill_blueprints
  end

  def embed_stat_blueprints

  end

  def embed_skill_blueprints

  end

end
