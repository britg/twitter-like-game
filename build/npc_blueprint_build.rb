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
  end

end
