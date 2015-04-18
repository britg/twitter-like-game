@build << -> {
  l = Location.create(
    {
      name: "Open Field",
      slug: :field,
      entrance_details: [
        "It's dusk. You find yourself in an open field of tall grass and sparse trees. There's a tavern ahead."
        ],
      explore_details: [
        "You explore the surrounding area."
      ],
      observe_details: [
        "You stand in an open field with short water starved trees. The wind is gusting to the east lightly.",
        "The light is fading, and you've slept on the hard ground for weeks. There's a tavern ahead.",
        "This field doesn't have much in the way of usable resources."
      ]
    }
  )

  l.landmarks.create(
    obj: Npc.slug(:injured_black_bear),
    discovery_details: [
      "You spot an injured juvenile [black bear](injured_black_bear) up ahead."
    ],
    discovery_req: [{
      skill: Skill.slug(:adventuring),
      range: 0..100
    }],
    aggro_details:[
      "The bear notices you immediately and attacks."
    ],
    aggro_req: [{
      skill: Skill.slug(:adventuring),
      range: 0..10
    }],
  )
}
