class Slot < ActiveHash::Base

  # Types

  HEAD = "head"
  CHEST = "chest"
  HANDS = "hands"
  LEGS = "legs"
  FEET = "feet"

  field :type
  field :item

end