class Location < ActiveHash::Base

  field :name
  field :slug
  field :path

  self.data = [
    {name: "World's End Tavern", slug: :tavern, path: "/tavern"},
    {name: "Diver's Den", slug: :diversden, path: "/divers-den"},
  ]

end