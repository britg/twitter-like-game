class LocationBuild < ObjectBuild

  def props
    {
      name: @hash["name"],
      zone: Zone.slug(@hash["_zone"]),
      slug: @hash["slug"],
      story: @hash["story"],
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
    embed_resource_nodes
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
      npc_blueprint: blueprint,
      _rarity: mob_hash["rarity"]
    )
  end

  def embed_resource_nodes
    @hash["resource_nodes"].try :each do |resource_node_hash|
      embed_resource_node resource_node_hash
    end
  end

  def embed_resource_node resource_node_hash
    node = @location.resource_nodes.find_or_create_by(
      name: resource_node_hash["name"]
    )

    loot_profile_slug = resource_node_hash["loot_profile"] || :basic
    node.update_attributes(
      discovery_details: resource_node_hash["discovery_details"],
      loot_profile: LootProfile.slug(loot_profile_slug)
    )
  end

  def embed_landmarks
    @hash["landmarks"].each do |landmark_hash|
      puts " =>> embedding landmark #{landmark_hash["slug"]} into #{@location.slug}"
      embed_landmark(landmark_hash)
    end
  end

  def embed_landmark landmark_hash
    build_dependency(landmark_hash["type"], landmark_hash["slug"])
    @location.landmarks.create(landmark_hash)
  end

end
