@build << -> {
  l = Location.create(
    {
      name: "Open Field",
      slug: :open_field,
      entrance_details: [
        "It's dusk. You find yourself in an open field of tall grass and sparse trees. A tavern's lights flicker in the distance."
        ],
      observe_details: [
        "You stand in an open field with short water starved trees. The wind is gusting to the east lightly.",
        "The light is fading, and you've slept on the hard ground for weeks. There's a tavern ahead.",
        "This field doesn't have much in the way of usable resources."
      ]
    }
  )

  @build.deferred -> {
    l.landmarks.create(
      slug: :mandrake_root,
      obj: Resource.slug(:mandrake_root)
    )

    l.landmarks.create(
      slug: :injured_black_bear,
      obj: Npc.slug(:injured_black_bear)
    )

    l.landmarks.create(
      slug: :worlds_end_tavern,
      obj: Location.slug(:worlds_end_tavern)
    )
  }
}
