@build << -> {
  dexterity = Stat.create(
    name: "Dexterity",
    slug: :dex,
    calculator_class: "DexterityCalculator"
  )
}