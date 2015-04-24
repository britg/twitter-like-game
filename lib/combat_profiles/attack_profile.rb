@build << -> {
  profile = CombatProfile.create(
    slug: :attack,
    name: "Attack",
  )

  profile.combat_profile_conditions.create(
    match: "*",
    result: :attack
  )
}
