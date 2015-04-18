@build << -> {
  mandrake_root = Resource.create(
    name: "Mandrake Root",
    type: Resource::HERB,
    slug: :mandrake_root
  )
}
