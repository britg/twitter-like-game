class LocationBuild < ObjectBuild

  def create
    @location = Location.create(
      name: @hash["name"],
      slug: @hash["slug"],
      adventuring_level: @hash["adventuring_level"],
      entrance_details: @hash["entrance_details"],
      explore_details: @hash["explore_details"],
      observe_details: @hash["observe_details"]
    )
    embed_mobs
    associate_resource_nodes
    embed_landmarks
  end

  def update

  end

  def associate_mobs
    @hash["mobs"].each do |mob_hash|
    end
  end

  def associate_mob mob_hash
    npc_blueprint = mob_hash["npc_blueprint"]
    build_dependency("NpcBlueprint", npc_blueprint)
    blueprint = NpcBlueprint.where(slug: npc_blueprint).first
    @location.mobs.create(
      npc_blueprint: blueprint,
      rarity: mob_hash["rarity"]
    )
  end

  def associate_resource_nodes

  end

  def embed_landmarks

  end

end
