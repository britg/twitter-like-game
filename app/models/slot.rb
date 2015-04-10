class Slot
  include Mongoid::Document

  # Types

  HEAD = "head"
  CHEST = "chest"
  HANDS = "hands"
  LEGS = "legs"
  FEET = "feet"

  field :type
  field :item

end