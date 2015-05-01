@build << -> {
  worlds_end_tavern = Location.create({
    name: "World's End Tavern",
    slug: :worlds_end_tavern
  })

  @build.deferred -> {
    worlds_end_tavern.landmarks.create(
      name: "Exit",
      slug: :tavern_door,
      obj: Location.slug(:open_field),
      auto_discovered: true
    )
  }
}
