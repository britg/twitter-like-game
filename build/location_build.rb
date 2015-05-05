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
    update
  end

  def update
    @location ||= existing
    @location.update_attributes(props)
    embed_mobs
    embed_landmarks
    @location
  end

  def embed_mobs
    @hash["mobs"].each do |mob_hash|
      embed_mob mob_hash
    end
  end

  def embed_mob mob_hash
    npc_blueprint = mob_hash["npc_blueprint"]
    blueprint = build_dependency("NpcBlueprint", npc_blueprint)
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
    @hash["landmarks"].each do |landmark_hash|
      embed_landmark(landmark_hash)
    end
  end

  def embed_landmark landmark_hash
    build_dependency(landmark_hash["type"], landmark_hash["slug"])
    @location.landmarks.create(
      name: landmark_hash["name"],
      slug: landmark_hash["slug"],
      rarity: landmark_hash["rarity"]
    )
  end

end
