# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

locations = Location.create([
  {
    name: "World's End Tavern",
    slug: "tavern"
  },
  {
    name: "Diver's Den",
    slug: "divers-den"
  }
])

npcs = Npc.create([
  {
    name: "Large, angry man",
    slug: :large_man,
    agent: {
      base_strength: 10
    }
  }
])


