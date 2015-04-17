@build << -> {
  Skill.create(
    name: "Adventuring",
    slug: :adventuring,
    group: "Basic",
    calculator_class: "AdventuringCalculator"
  )
}
