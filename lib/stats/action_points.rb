@build << -> {
  ap = Stat.create(
    name: "AP",
    slug: :ap,
    calculator_class: "APCalculator"
  )
}
