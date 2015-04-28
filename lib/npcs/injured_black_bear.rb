@build << -> {
  injured_black_bear = NpcBlueprint.create(
    name: "Injured Black Bear",
    slug: :injured_black_bear,
    combat_profile: CombatProfile.slug(:attack)
  )

  injured_black_bear.stat_blueprints.create(
    slug: :hp,
    range: (8..12)
  )
  injured_black_bear.stat_blueprints.create(
    slug: :str,
    range: (8..12)
  )
}
