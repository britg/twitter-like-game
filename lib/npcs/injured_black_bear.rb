@build << -> {
  injured_black_bear = Npc.create(
    name: "Injured Black Bear",
    slug: :injured_black_bear,
  )

  injured_black_bear.create_agent
  injured_black_bear.stats.create(
    stat: Stat.slug(:str),
    base_value: 8
  )
}
