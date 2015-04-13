@build << -> {
  l = Location.create(
    {
      name: "Open Field",
      slug: :field,
      entrance_details: [
        "It's dusk. You find yourself in an open field of tall grass and sparse trees."
        ],
      explore_details: [
        "You explore the surrounding area."
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
