class LocationBuild < ObjectBuild

  def props
    {
      name: @hash["name"],
      slug: @hash["slug"],
      adventuring_level: @hash["adventuring_level"],
      entrance_details: @hash["entrance_details"],
      explore_details: @hash["explore_details"],
      observe_details: @hash["observe_details"]
    }
  end

  def create
    @location = Location.create(props)
    embed_mobs
    associate_resource_nodes
    embed_landmarks
  end

  def update
    @location = existing
    @location.update_attributes(props)
    embed_mobs
  end

  def embed_mobs
    @hash["mobs"].each do |mob_hash|
      embed_mob mob_hash
    end
  end

  def embed_mob mob_hash
    npc_blueprint = mob_hash["npc_blueprint"]
    build_dependency("NpcBlueprint", npc_blueprint)
    blueprint = NpcBlueprint.where(slug: npc_blueprint).first
    mob = @location.mobs.find_or_create_by(
      npc_blueprint: blueprint
    )
    mob.update_attributes(
      rarity: mob_hash["rarity"]
    )
  end

  def associate_resource_nodes

  end

  def embed_landmarks

  end

end
