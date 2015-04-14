@build << -> {
  strength = Stat.create(
    name: "Strength",
    slug: :str,
    calculator_class: "StrengthCalculator"
  )
}