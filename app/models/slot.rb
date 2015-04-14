class Slot
  include Mongoid::Document
  include HasSlug

  HEAD = "head"
  CHEST = "chest"
  HANDS = "hands"
  LEGS = "legs"
  FEET = "feet"

  field :name, type: String

end